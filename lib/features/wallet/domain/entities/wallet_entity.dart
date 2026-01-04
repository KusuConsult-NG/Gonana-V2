import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final double balanceNgn;
  final double cryptoBalanceCcd;
  final double cryptoBalanceEth;
  final String? virtualAccountNumber;
  final String? bankName;
  final Map<String, String>? cryptoAddresses;

  // KYC-gated wallet fields
  final bool isKycVerified;
  final Map<String, String>? multiChainAddresses; // Chain name -> Address
  final DateTime? kycVerifiedAt;

  const WalletEntity({
    required this.balanceNgn,
    required this.cryptoBalanceCcd,
    required this.cryptoBalanceEth,
    this.virtualAccountNumber,
    this.bankName,
    this.cryptoAddresses,
    this.isKycVerified = false,
    this.multiChainAddresses,
    this.kycVerifiedAt,
  });

  @override
  List<Object?> get props => [
    balanceNgn,
    cryptoBalanceCcd,
    cryptoBalanceEth,
    virtualAccountNumber,
    bankName,
    cryptoAddresses,
    isKycVerified,
    multiChainAddresses,
    kycVerifiedAt,
  ];
}
