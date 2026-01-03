// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  buyerId: json['buyerId'] as String,
  sellerId: json['sellerId'] as String,
  sellerName: json['sellerName'] as String,
  productName: json['productName'] as String,
  productImageUrl: json['productImageUrl'] as String,
  totalPrice: (json['totalPrice'] as num).toDouble(),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  date: DateTime.parse(json['date'] as String),
  logisticsCompany: json['logisticsCompany'] as String?,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'sellerName': instance.sellerName,
      'productName': instance.productName,
      'productImageUrl': instance.productImageUrl,
      'totalPrice': instance.totalPrice,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
      'logisticsCompany': instance.logisticsCompany,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};
