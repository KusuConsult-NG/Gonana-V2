// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
  balanceNgn: (json['balanceNgn'] as num).toDouble(),
  cryptoBalanceCcd: (json['cryptoBalanceCcd'] as num).toDouble(),
  cryptoBalanceEth: (json['cryptoBalanceEth'] as num).toDouble(),
  virtualAccountNumber: json['virtualAccountNumber'] as String?,
  bankName: json['bankName'] as String?,
  cryptoAddresses: (json['cryptoAddresses'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'balanceNgn': instance.balanceNgn,
      'cryptoBalanceCcd': instance.cryptoBalanceCcd,
      'cryptoBalanceEth': instance.cryptoBalanceEth,
      'virtualAccountNumber': instance.virtualAccountNumber,
      'bankName': instance.bankName,
      'cryptoAddresses': instance.cryptoAddresses,
    };
