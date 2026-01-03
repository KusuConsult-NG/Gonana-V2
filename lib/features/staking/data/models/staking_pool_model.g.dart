// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staking_pool_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakingPoolModel _$StakingPoolModelFromJson(Map<String, dynamic> json) =>
    StakingPoolModel(
      id: json['id'] as String,
      name: json['name'] as String,
      apy: (json['apy'] as num).toDouble(),
      duration: json['duration'] as String,
      minStakingAmount: (json['minStakingAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$StakingPoolModelToJson(StakingPoolModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'apy': instance.apy,
      'duration': instance.duration,
      'minStakingAmount': instance.minStakingAmount,
    };
