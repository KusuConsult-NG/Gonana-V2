import 'package:dartz/dartz.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<String, List<OrderEntity>>> getBuyerOrders(String buyerId);
  Future<Either<String, List<OrderEntity>>> getSellerSales(String sellerId);
  Future<Either<String, OrderEntity>> createOrder(OrderEntity order);
  Future<Either<String, Unit>> updateOrderStatus(
    String orderId,
    OrderStatus status,
  );
}
