import '../../../flutter_paystack.dart';

abstract class BaseRequestBody {
  final fieldDevice = 'device';
  String? _device;

  BaseRequestBody() {
    _setDeviceId();
  }

  Map<String, String?> paramsMap();

  String? get device => _device;

  void _setDeviceId() {
    final String deviceId = PaystackPlugin.platformInfo.deviceId;
    _device = deviceId;
  }
}
