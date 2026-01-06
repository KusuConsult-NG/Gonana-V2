import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
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

  const OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromEntity(OrderEntity entity) => OrderModel(
    id: entity.id,
    buyerId: entity.buyerId,
    sellerId: entity.sellerId,
    sellerName: entity.sellerName,
    productName: entity.productName,
    productImageUrl: entity.productImageUrl,
    totalPrice: entity.totalPrice,
    status: entity.status,
    date: entity.date,
    logisticsCompany: entity.logisticsCompany,
    shippingAddress: entity.shippingAddress,
    recipientName: entity.recipientName,
    recipientPhone: entity.recipientPhone,
  );

  OrderEntity toEntity() => OrderEntity(
    id: id,
    buyerId: buyerId,
    sellerId: sellerId,
    sellerName: sellerName,
    productName: productName,
    productImageUrl: productImageUrl,
    totalPrice: totalPrice,
    status: status,
    date: date,
    logisticsCompany: logisticsCompany,
    shippingAddress: shippingAddress,
    recipientName: recipientName,
    recipientPhone: recipientPhone,
  );
}
