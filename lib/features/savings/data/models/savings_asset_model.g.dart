// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingsAssetModel _$SavingsAssetModelFromJson(Map<String, dynamic> json) =>
    SavingsAssetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      apy: (json['apy'] as num).toDouble(),
      minDuration: json['minDuration'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SavingsAssetModelToJson(SavingsAssetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'apy': instance.apy,
      'minDuration': instance.minDuration,
      'description': instance.description,
    };
