import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../model/transaction_api_response.dart';
import 'base_service.dart';
import 'contracts/cards_service_contract.dart';
import '../../common/exceptions.dart';
import '../../common/my_strings.dart';
import '../../common/extensions.dart';
import 'package:http/http.dart' as http;

class CardService with BaseApiService implements CardServiceContract {
  @override
  Future<TransactionApiResponse> chargeCard(Map<String, String?> fields) async {
    final url = '$baseUrl/charge/mobile_charge';

    final http.Response response =
        await http.post(url.toUri(), body: fields, headers: headers);
    final body = response.body;

    final statusCode = response.statusCode;

    switch (statusCode) {
      case HttpStatus.ok:
        final Map<String, dynamic> responseBody = json.decode(body);
        return TransactionApiResponse.fromMap(responseBody);
      case HttpStatus.gatewayTimeout:
        throw ChargeException('Gateway timeout error');
      default:
        throw ChargeException(Strings.unKnownResponse);
    }
  }

  @override
  Future<TransactionApiResponse> validateCharge(
      Map<String, String?> fields) async {
    final url = '$baseUrl/charge/validate';

    final http.Response response =
        await http.post(url.toUri(), body: fields, headers: headers);
    final body = response.body;

    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseBody = json.decode(body);
      return TransactionApiResponse.fromMap(responseBody);
    } else {
      throw CardException('validate charge transaction failed with '
          'status code: $statusCode and response: $body');
    }
  }

  @override
  Future<TransactionApiResponse> reQueryTransaction(String? trans) async {
    final url = '$baseUrl/requery/$trans';

    final http.Response response = await http.get(url.toUri(), headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseBody = json.decode(body);
      return TransactionApiResponse.fromMap(responseBody);
    } else {
      throw ChargeException('requery transaction failed with status code: '
          '$statusCode and response: $body');
    }
  }
}
