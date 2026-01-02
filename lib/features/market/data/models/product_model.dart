import '../../domain/entities/product_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.amount,
    super.usdPrice,
    required super.imageUrl,
    required super.description,
    super.isHotDeal,
    super.discountPercentage,
    super.location,
    super.quantity,
    super.shippingMethods,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String,
    title: json['title'] as String,
    amount: (json['amount'] as num).toDouble(),
    usdPrice: (json['usdPrice'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String,
    description: json['description'] as String,
    isHotDeal: json['isHotDeal'] as bool? ?? false,
    discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
    location: json['location'] as String?,
    quantity: json['quantity'] as int?,
    shippingMethods: (json['shippingMethods'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'usdPrice': usdPrice,
    'imageUrl': imageUrl,
    'description': description,
    'isHotDeal': isHotDeal,
    'discountPercentage': discountPercentage,
    'location': location,
    'quantity': quantity,
    'shippingMethods': shippingMethods,
  };
}
