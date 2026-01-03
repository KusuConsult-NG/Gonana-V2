import 'package:equatable/equatable.dart';

enum OrderStatus { pending, shipped, delivered, cancelled }

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
  ];
}
