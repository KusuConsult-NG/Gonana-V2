part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.success(String message) = _Success;
  const factory PaymentState.error(String message) = _Error;
  const factory PaymentState.virtualAccountGenerated(String accountNumber) =
      _VirtualAccountGenerated;
  const factory PaymentState.cryptoAddressesGenerated(
    Map<String, String> addresses,
  ) = _CryptoAddressesGenerated;
}
