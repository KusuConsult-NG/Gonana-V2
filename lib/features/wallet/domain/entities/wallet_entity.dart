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

  WalletEntity copyWith({
    double? balanceNgn,
    double? cryptoBalanceCcd,
    double? cryptoBalanceEth,
    String? virtualAccountNumber,
    String? bankName,
    Map<String, String>? cryptoAddresses,
    bool? isKycVerified,
    Map<String, String>? multiChainAddresses,
    DateTime? kycVerifiedAt,
  }) {
    return WalletEntity(
      balanceNgn: balanceNgn ?? this.balanceNgn,
      cryptoBalanceCcd: cryptoBalanceCcd ?? this.cryptoBalanceCcd,
      cryptoBalanceEth: cryptoBalanceEth ?? this.cryptoBalanceEth,
      virtualAccountNumber: virtualAccountNumber ?? this.virtualAccountNumber,
      bankName: bankName ?? this.bankName,
      cryptoAddresses: cryptoAddresses ?? this.cryptoAddresses,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      multiChainAddresses: multiChainAddresses ?? this.multiChainAddresses,
      kycVerifiedAt: kycVerifiedAt ?? this.kycVerifiedAt,
    );
  }

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
