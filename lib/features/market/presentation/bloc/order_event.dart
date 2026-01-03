import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_event.freezed.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.loadBuyerOrders(String buyerId) = LoadBuyerOrders;
  const factory OrderEvent.loadSellerSales(String sellerId) = LoadSellerSales;
  const factory OrderEvent.createOrder(OrderEntity order) = CreateOrder;
  const factory OrderEvent.updateStatus(String orderId, OrderStatus status) =
      UpdateStatus;
}
