// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStakeModel _$UserStakeModelFromJson(Map<String, dynamic> json) =>
    UserStakeModel(
      id: json['id'] as String,
      poolId: json['poolId'] as String,
      poolName: json['poolName'] as String,
      amount: (json['amount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      expectedReturn: (json['expectedReturn'] as num).toDouble(),
    );

Map<String, dynamic> _$UserStakeModelToJson(UserStakeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poolId': instance.poolId,
      'poolName': instance.poolName,
      'amount': instance.amount,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'expectedReturn': instance.expectedReturn,
    };
