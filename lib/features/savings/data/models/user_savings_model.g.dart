// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_savings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSavingsModel _$UserSavingsModelFromJson(Map<String, dynamic> json) =>
    UserSavingsModel(
      id: json['id'] as String,
      assetId: json['assetId'] as String,
      assetName: json['assetName'] as String,
      balance: (json['balance'] as num).toDouble(),
      accruedProfit: (json['accruedProfit'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      nextPayoutDate: json['nextPayoutDate'] == null
          ? null
          : DateTime.parse(json['nextPayoutDate'] as String),
    );

Map<String, dynamic> _$UserSavingsModelToJson(UserSavingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetId': instance.assetId,
      'assetName': instance.assetName,
      'balance': instance.balance,
      'accruedProfit': instance.accruedProfit,
      'startDate': instance.startDate.toIso8601String(),
      'nextPayoutDate': instance.nextPayoutDate?.toIso8601String(),
    };
