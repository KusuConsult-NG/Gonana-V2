import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final double balanceNgn;
  final double cryptoBalanceCcd;
  final double cryptoBalanceEth;

  const WalletEntity({
    required this.balanceNgn,
    required this.cryptoBalanceCcd,
    required this.cryptoBalanceEth,
  });

  @override
  List<Object?> get props => [balanceNgn, cryptoBalanceCcd, cryptoBalanceEth];
}
