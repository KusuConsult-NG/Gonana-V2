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
  description: json['description'] as String,
  isHotDeal: json['isHotDeal'] as bool? ?? false,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
  location: json['location'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  shippingMethods: (json['shippingMethods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sellerId: json['sellerId'] as String?,
  sellerName: json['sellerName'] as String?,
  sellerPhoto: json['sellerPhoto'] as String?,
  unit: json['unit'] as String?,
  availableQuantity: (json['availableQuantity'] as num?)?.toDouble(),
  shippingPrice: (json['shippingPrice'] as num?)?.toDouble(),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  initialStock: (json['initialStock'] as num?)?.toInt(),
  soldCount: (json['soldCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'usdPrice': instance.usdPrice,
      'description': instance.description,
      'isHotDeal': instance.isHotDeal,
      'discountPercentage': instance.discountPercentage,
      'location': instance.location,
      'quantity': instance.quantity,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'shippingMethods': instance.shippingMethods,
      'sellerId': instance.sellerId,
      'sellerName': instance.sellerName,
      'sellerPhoto': instance.sellerPhoto,
      'unit': instance.unit,
      'availableQuantity': instance.availableQuantity,
      'shippingPrice': instance.shippingPrice,
      'initialStock': instance.initialStock,
      'soldCount': instance.soldCount,
    };
