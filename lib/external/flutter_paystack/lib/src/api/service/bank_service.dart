import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import '../model/transaction_api_response.dart';
import '../request/bank_charge_request_body.dart';
import 'base_service.dart';
import 'contracts/banks_service_contract.dart';
import '../../common/exceptions.dart';
import '../../common/my_strings.dart';
import '../../models/bank.dart';
import '../../common/extensions.dart';
import 'package:http/http.dart' as http;

class BankService with BaseApiService implements BankServiceContract {
  @override
  Future<String?> getTransactionId(String? accessCode) async {
    final url =
        'https://api.paystack.co/transaction/verify_access_code/$accessCode';
    try {
      final http.Response response = await http.get(url.toUri());
      final Map responseBody = jsonDecode(response.body);
      final bool? status = responseBody['status'];
      if (response.statusCode == HttpStatus.ok && status!) {
        return responseBody['data']['id'].toString();
      }
    } catch (e) {}
    return null;
  }

  @override
  Future<TransactionApiResponse> chargeBank(
      BankChargeRequestBody? requestBody) async {
    final url =
        '$baseUrl/bank/charge_account/${requestBody!.account.bank!.id}/${requestBody.transactionId}';
    return _getChargeFuture(url, fields: requestBody.paramsMap());
  }

  @override
  Future<TransactionApiResponse> validateToken(
      BankChargeRequestBody? requestBody, Map<String, String?> fields) async {
    final url =
        '$baseUrl/bank/validate_token/${requestBody!.account.bank!.id}/${requestBody.transactionId}';
    return _getChargeFuture(url, fields: fields);
  }

  Future<TransactionApiResponse> _getChargeFuture(String url,
      {var fields}) async {
    final http.Response response =
        await http.post(url.toUri(), body: fields, headers: headers);
    return _getResponseFuture(response);
  }

  TransactionApiResponse _getResponseFuture(http.Response response) {
    final body = response.body;

    final Map<String, dynamic>? responseBody = json.decode(body);

    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return TransactionApiResponse.fromMap(responseBody!);
    } else {
      throw ChargeException(Strings.unKnownResponse);
    }
  }

  @override
  Future<List<Bank>?> fetchSupportedBanks() async {
    return banksMemo!.runOnce(() async {
      return await _fetchSupportedBanks();
    });
  }

  Future<List<Bank>?> _fetchSupportedBanks() async {
    const url = 'https://api.paystack.co/bank?pay_with_bank=true';
    try {
      final http.Response response = await http.get(url.toUri());
      final Map<String, dynamic> body = json.decode(response.body);
      final data = body['data'];
      final List<Bank> banks = [];
      for (var bank in data) {
        banks.add(Bank(bank['name'], bank['id']));
      }
      return banks;
    } catch (e) {}
    return null;
  }
}

AsyncMemoizer<List<Bank>?>? banksMemo = AsyncMemoizer<List<Bank>?>();
