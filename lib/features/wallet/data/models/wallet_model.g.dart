// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
  balanceNgn: (json['balanceNgn'] as num).toDouble(),
  cryptoBalanceCcd: (json['cryptoBalanceCcd'] as num).toDouble(),
  cryptoBalanceEth: (json['cryptoBalanceEth'] as num).toDouble(),
);

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'balanceNgn': instance.balanceNgn,
      'cryptoBalanceCcd': instance.cryptoBalanceCcd,
      'cryptoBalanceEth': instance.cryptoBalanceEth,
    };
