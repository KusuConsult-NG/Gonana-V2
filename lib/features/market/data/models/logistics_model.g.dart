// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogisticsModel _$LogisticsModelFromJson(Map<String, dynamic> json) =>
    LogisticsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      estimatedDelivery: json['estimatedDelivery'] as String,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$LogisticsModelToJson(LogisticsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'estimatedDelivery': instance.estimatedDelivery,
      'logoUrl': instance.logoUrl,
    };
