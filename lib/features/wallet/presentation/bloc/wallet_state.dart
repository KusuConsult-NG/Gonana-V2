part of 'wallet_bloc.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.loading() = _Loading;
  const factory WalletState.loaded({
    required WalletEntity wallet,
    required List<TransactionEntity> transactions,
  }) = _Loaded;
  const factory WalletState.error(String message) = _Error;
}
