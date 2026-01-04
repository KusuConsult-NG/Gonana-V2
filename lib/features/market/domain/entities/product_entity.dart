import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final double? usdPrice;
  final List<String> images;
  final String description;
  final bool isHotDeal;
  final double? discountPercentage;
  final String? location;
  final int? quantity;
  final double rating;
  final int reviewCount;
  final List<String>? shippingMethods;
  final String? sellerId;
  final String? sellerName;
  final String? sellerPhoto;
  final String? unit; // e.g. KG, Ton, Bag
  final double? availableQuantity; // Inventory count
  final double? shippingPrice; // For Farmer Shipping
  final int? initialStock; // For progress bar
  final int? soldCount; // For progress bar

  String get imageUrl => images.isNotEmpty ? images.first : '';

  const ProductEntity({
    required this.id,
    required this.title,
    required this.amount,
    this.usdPrice,
    this.images = const [],
    required this.description,
    this.isHotDeal = false,
    this.discountPercentage,
    this.location,
    this.quantity,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.shippingMethods,
    this.sellerId,
    this.sellerName,
    this.sellerPhoto,
    this.unit,
    this.availableQuantity,
    this.shippingPrice,
    this.initialStock,
    this.soldCount,
  });

  ProductEntity copyWith({
    String? id,
    String? title,
    double? amount,
    double? usdPrice,
    List<String>? images,
    String? description,
    bool? isHotDeal,
    double? discountPercentage,
    String? location,
    int? quantity,
    double? rating,
    int? reviewCount,
    List<String>? shippingMethods,
    String? sellerId,
    String? sellerName,
    String? sellerPhoto,
    String? unit,
    double? availableQuantity,
    double? shippingPrice,
    int? initialStock,
    int? soldCount,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      usdPrice: usdPrice ?? this.usdPrice,
      images: images ?? this.images,
      description: description ?? this.description,
      isHotDeal: isHotDeal ?? this.isHotDeal,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerPhoto: sellerPhoto ?? this.sellerPhoto,
      unit: unit ?? this.unit,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      shippingPrice: shippingPrice ?? this.shippingPrice,
      initialStock: initialStock ?? this.initialStock,
      soldCount: soldCount ?? this.soldCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    usdPrice,
    images,
    description,
    isHotDeal,
    discountPercentage,
    location,
    quantity,
    rating,
    reviewCount,
    shippingMethods,
    sellerId,
    sellerName,
    sellerPhoto,
    unit,
    availableQuantity,
    shippingPrice,
    initialStock,
    soldCount,
  ];
}
