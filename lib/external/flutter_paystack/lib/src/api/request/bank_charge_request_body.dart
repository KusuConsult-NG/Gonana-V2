import 'base_request_body.dart';
import '../../models/bank.dart';
import '../../models/charge.dart';

class BankChargeRequestBody extends BaseRequestBody {
  final String _accessCode;
  final BankAccount _account;
  String? _birthday;
  String? _token;
  String? transactionId;

  BankChargeRequestBody(Charge charge)
      : _accessCode = charge.accessCode!,
        _account = charge.account!;

  Map<String, String?> tokenParams() => {fieldDevice: device, 'token': _token};

  @override
  Map<String, String?> paramsMap() {
    final map = {fieldDevice: device, 'account_number': account.number};
    map['birthday'] = _birthday;
    return map..removeWhere((key, value) => value == null || value.isEmpty);
  }

  set token(String value) => _token = value;

  set birthday(String value) => _birthday = value;

  BankAccount get account => _account;

  String get accessCode => _accessCode;
}
