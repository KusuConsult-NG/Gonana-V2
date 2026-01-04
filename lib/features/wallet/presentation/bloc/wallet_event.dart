part of 'wallet_bloc.dart';

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.loadWalletData() = _LoadWalletData;
  const factory WalletEvent.payOrder({
    required double amount,
    required String orderId,
  }) = _PayOrder;
}
