import 'dart:async';

import 'package:flutter/material.dart';
import '../api/model/transaction_api_response.dart';
import '../api/request/bank_charge_request_body.dart';
import '../api/service/contracts/banks_service_contract.dart';
import '../common/exceptions.dart';
import '../common/my_strings.dart';
import '../common/paystack.dart';
import '../models/charge.dart';
import '../models/checkout_response.dart';
import 'base_transaction_manager.dart';

class BankTransactionManager extends BaseTransactionManager {
  BankChargeRequestBody? chargeRequestBody;
  final BankServiceContract service;

  BankTransactionManager(
      {required this.service,
      required Charge charge,
      required BuildContext context,
      required String publicKey})
      : super(charge: charge, context: context, publicKey: publicKey);

  Future<CheckoutResponse> chargeBank() async {
    await initiate();
    return sendCharge();
  }

  @override
  postInitiate() {
    chargeRequestBody = BankChargeRequestBody(charge);
  }

  @override
  Future<CheckoutResponse> sendChargeOnServer() {
    return _getTransactionId();
  }

  Future<CheckoutResponse> _getTransactionId() async {
    final String? id = await service.getTransactionId(chargeRequestBody!.accessCode);
    if (id == null || id.isEmpty) {
      return notifyProcessingError('Unable to verify access code');
    }

    chargeRequestBody!.transactionId = id;
    return _chargeAccount();
  }

  Future<CheckoutResponse> _chargeAccount() {
    final Future<TransactionApiResponse> future =
        service.chargeBank(chargeRequestBody);
    return handleServerResponse(future);
  }

  Future<CheckoutResponse> _sendTokenToServer() {
    final Future<TransactionApiResponse> future = service.validateToken(
        chargeRequestBody, chargeRequestBody!.tokenParams());
    return handleServerResponse(future);
  }

  @override
  Future<CheckoutResponse> handleApiResponse(
      TransactionApiResponse response) async {
    final auth = response.auth;

    if (response.status == 'success') {
      setProcessingOff();
      return onSuccess(transaction);
    }

    if (auth == 'failed' || auth == 'timeout') {
      return notifyProcessingError(ChargeException(response.message));
    }

    if (auth == 'birthday') {
      return getBirthdayFrmUI(response);
    }

    if (auth == 'payment_token' || auth == 'registration_token') {
      return getOtpFrmUI(response: response);
    }

    return notifyProcessingError(
        PaystackException(response.message ?? Strings.unKnownResponse));
  }

  @override
  Future<CheckoutResponse> handleOtpInput(
      String token, TransactionApiResponse? response) {
    chargeRequestBody!.token = token;
    return _sendTokenToServer();
  }

  @override
  Future<CheckoutResponse> handleBirthdayInput(
      String birthday, TransactionApiResponse response) {
    chargeRequestBody!.birthday = birthday;
    return _chargeAccount();
  }

  @override
  CheckoutMethod checkoutMethod() => CheckoutMethod.bank;
}
