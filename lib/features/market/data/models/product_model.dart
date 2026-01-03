import '../../domain/entities/product_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: overridden_fields
  final List<String> images;

  const ProductModel({
    required super.id,
    required super.title,
    required super.amount,
    super.usdPrice,
    this.images = const [],
    required super.description,
    super.isHotDeal,
    super.discountPercentage,
    super.location,
    super.quantity,
    super.shippingMethods,
    super.sellerId,
    super.sellerName,
    super.sellerPhoto,
    super.unit,
    super.availableQuantity,
    super.shippingPrice,
    super.rating = 0.0,
    super.reviewCount = 0,
  }) : super(images: images);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imgs = [];
    if (json['images'] != null) {
      imgs = (json['images'] as List<dynamic>).map((e) => e as String).toList();
    } else if (json['imageUrl'] != null) {
      imgs = [json['imageUrl'] as String];
    }

    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      usdPrice: (json['usdPrice'] as num?)?.toDouble(),
      images: imgs,
      description: json['description'] as String,
      isHotDeal: json['isHotDeal'] as bool? ?? false,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      location: json['location'] as String?,
      quantity: json['quantity'] as int?,
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
      reviewCount: json['reviewCount'] as int? ?? 0,
    );
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'usdPrice': usdPrice,
    'images': images,
    'imageUrl': images.isNotEmpty ? images.first : '', // Legacy support
    'description': description,
    'isHotDeal': isHotDeal,
    'discountPercentage': discountPercentage,
    'location': location,
    'quantity': quantity,
    'shippingMethods': shippingMethods,
    'sellerId': sellerId,
    'sellerName': sellerName,
    'sellerPhoto': sellerPhoto,
    'unit': unit,
    'availableQuantity': availableQuantity,
    'shippingPrice': shippingPrice,
    'rating': rating,
    'reviewCount': reviewCount,
  };
}
