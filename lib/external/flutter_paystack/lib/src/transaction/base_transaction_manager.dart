import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../api/model/transaction_api_response.dart';
import '../common/exceptions.dart';
import '../common/paystack.dart';
import '../common/utils.dart';
import '../models/card.dart';
import '../models/charge.dart';
import '../models/checkout_response.dart';
import '../models/transaction.dart';
import '../widgets/birthday_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/otp_widget.dart';
import '../widgets/pin_widget.dart';

abstract class BaseTransactionManager {
  bool processing = false;
  final Charge charge;
  final BuildContext context;
  final Transaction transaction = Transaction();
  final String publicKey;

  BaseTransactionManager({
    required this.charge,
    required this.context,
    required this.publicKey,
  });

  Future<void> initiate() async {
    if (processing) throw ProcessingException();

    setProcessingOn();
    await postInitiate();
  }

  Future<CheckoutResponse> sendCharge() async {
    try {
      return sendChargeOnServer();
    } catch (e) {
      return notifyProcessingError(e);
    }
  }

  Future<CheckoutResponse> handleApiResponse(
      TransactionApiResponse apiResponse);

  Future<CheckoutResponse> _initApiResponse(
      TransactionApiResponse? apiResponse) {
    apiResponse ??= TransactionApiResponse.unknownServerResponse();

    transaction.loadFromResponse(apiResponse);

    return handleApiResponse(apiResponse);
  }

  Future<CheckoutResponse> handleServerResponse(
      Future<TransactionApiResponse> future) async {
    try {
      final apiResponse = await future;
      return _initApiResponse(apiResponse);
    } catch (e) {
      return notifyProcessingError(e);
    }
  }

  CheckoutResponse notifyProcessingError(Object e) {
    setProcessingOff();

    if (e is TimeoutException || e is SocketException) {
      e = 'Please  check your internet connection or try again later';
    }
    return CheckoutResponse(
        message: e.toString(),
        reference: transaction.reference,
        status: false,
        card: charge.card?..nullifyNumber(),
        account: charge.account,
        method: checkoutMethod(),
        verify: e is! PaystackException);
  }

  bool setProcessingOff() => processing = false;

  bool setProcessingOn() => processing = true;

  Future<CheckoutResponse> getCardInfoFrmUI(PaymentCard? currentCard) async {
    final PaymentCard? newCard = await showDialog<PaymentCard>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CardInputWidget(currentCard));

    if (newCard == null || !newCard.isValid()) {
      return notifyProcessingError(CardException('Invalid card parameters'));
    } else {
      charge.card = newCard;
      return handleCardInput();
    }
  }

  Future<CheckoutResponse> getOtpFrmUI(
      {String? message, TransactionApiResponse? response}) async {
    assert(message != null || response != null);
    final String? otp = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => OtpWidget(
            message: message ?? (response!.displayText == null || response.displayText!.isEmpty
                    ? response.message
                    : response.displayText)));

    if (otp != null && otp.isNotEmpty) {
      return handleOtpInput(otp, response);
    } else {
      return notifyProcessingError(
          PaystackException("You did not provide an OTP"));
    }
  }

  Future<CheckoutResponse> getAuthFrmUI(String? url) async {
    TransactionApiResponse apiResponse =
        TransactionApiResponse.unknownServerResponse();

    final String? result = await Utils.methodChannel
        .invokeMethod<String>('getAuthorization', {"authUrl": url});

    if (result != null) {
      try {
        final Map<String, dynamic> responseMap = json.decode(result);
        apiResponse = TransactionApiResponse.fromMap(responseMap);
      } catch (e) {}
    }
    return _initApiResponse(apiResponse);
  }

  Future<CheckoutResponse> getPinFrmUI() async {
    final String? pin = await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const PinWidget());

    if (pin != null && pin.length == 4) {
      return handlePinInput(pin);
    } else {
      return notifyProcessingError(
          PaystackException("PIN must be exactly 4 digits"));
    }
  }

  Future<CheckoutResponse> getBirthdayFrmUI(
      TransactionApiResponse response) async {
    final String? birthday = await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final messageText =
              response.displayText == null || response.displayText!.isEmpty
                  ? response.message!
                  : response.displayText!;
          return BirthdayWidget(message: messageText);
        });

    if (birthday != null && birthday.isNotEmpty) {
      return handleBirthdayInput(birthday, response);
    } else {
      return notifyProcessingError(
          PaystackException("Date of birth not supplied"));
    }
  }

  CheckoutResponse onSuccess(Transaction transaction) {
    return CheckoutResponse(
        message: transaction.message,
        reference: transaction.reference,
        status: true,
        card: charge.card?..nullifyNumber(),
        account: charge.account,
        method: checkoutMethod(),
        verify: true);
  }

  Future<CheckoutResponse> handleCardInput() {
    throw UnsupportedError(
        "Handling of card input not supported for Bank payment method");
  }

  Future<CheckoutResponse> handleOtpInput(
      String otp, TransactionApiResponse? response);

  Future<CheckoutResponse> handlePinInput(String pin) {
    throw UnsupportedError("Pin Input not supported for ${checkoutMethod()}");
  }

  postInitiate();

  Future<CheckoutResponse> handleBirthdayInput(
      String birthday, TransactionApiResponse response) {
    throw UnsupportedError(
        "Birthday Input not supported for ${checkoutMethod()}");
  }

  CheckoutMethod checkoutMethod();

  Future<CheckoutResponse> sendChargeOnServer();
}
