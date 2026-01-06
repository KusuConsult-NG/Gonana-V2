import 'package:equatable/equatable.dart';

enum OrderStatus { pending, paid, shipped, delivered, cancelled }

class OrderEntity extends Equatable {
  final String id;
  final String buyerId;
  final String sellerId;
  final String sellerName;
  final String productName;
  final String productImageUrl;
  final double totalPrice;
  final OrderStatus status;
  final DateTime date;
  final String? logisticsCompany;
  final String? shippingAddress;
  final String? recipientName;
  final String? recipientPhone;

  const OrderEntity({
    required this.id,
    required this.buyerId,
    required this.sellerId,
    required this.sellerName,
    required this.productName,
    required this.productImageUrl,
    required this.totalPrice,
    required this.status,
    required this.date,
    this.logisticsCompany,
    this.shippingAddress,
    this.recipientName,
    this.recipientPhone,
  });

  @override
  List<Object?> get props => [
    id,
    buyerId,
    sellerId,
    sellerName,
    productName,
    productImageUrl,
    totalPrice,
    status,
    date,
    logisticsCompany,
    shippingAddress,
    recipientName,
    recipientPhone,
  ];
}
