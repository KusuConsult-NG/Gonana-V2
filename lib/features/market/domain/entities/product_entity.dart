import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final double? usdPrice;
  final String imageUrl;
  final String description;
  final bool isHotDeal;
  final double? discountPercentage;
  final String? location;
  final int? quantity;
  final List<String>? shippingMethods;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.amount,
    this.usdPrice,
    required this.imageUrl,
    required this.description,
    this.isHotDeal = false,
    this.discountPercentage,
    this.location,
    this.quantity,
    this.shippingMethods,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    usdPrice,
    imageUrl,
    description,
    isHotDeal,
    discountPercentage,
    location,
    quantity,
    shippingMethods,
  ];
}
