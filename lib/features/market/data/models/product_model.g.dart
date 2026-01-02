// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  title: json['title'] as String,
  amount: (json['amount'] as num).toDouble(),
  usdPrice: (json['usdPrice'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String,
  isHotDeal: json['isHotDeal'] as bool? ?? false,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
  location: json['location'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  shippingMethods: (json['shippingMethods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'usdPrice': instance.usdPrice,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'isHotDeal': instance.isHotDeal,
      'discountPercentage': instance.discountPercentage,
      'location': instance.location,
      'quantity': instance.quantity,
      'shippingMethods': instance.shippingMethods,
    };
