import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final double balanceNgn;
  final double cryptoBalanceCcd;
  final double cryptoBalanceEth;
  final String? virtualAccountNumber;
  final String? bankName;
  final Map<String, String>? cryptoAddresses;

  const WalletEntity({
    required this.balanceNgn,
    required this.cryptoBalanceCcd,
    required this.cryptoBalanceEth,
    this.virtualAccountNumber,
    this.bankName,
    this.cryptoAddresses,
  });

  @override
  List<Object?> get props => [
    balanceNgn,
    cryptoBalanceCcd,
    cryptoBalanceEth,
    virtualAccountNumber,
    bankName,
    cryptoAddresses,
  ];
}
