import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepositoryImpl(this._firestore);

  @override
  Future<Either<String, OrderEntity>> createOrder(OrderEntity order) async {
    try {
      final model = OrderModel.fromEntity(order);
      await _firestore.collection('orders').doc(model.id).set(model.toJson());
      return Right(order);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderEntity>>> getBuyerOrders(
    String buyerId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('buyerId', isEqualTo: buyerId)
          .orderBy('date', descending: true)
          .get();

      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()).toEntity())
          .toList();
      return Right(orders);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderEntity>>> getSellerSales(
    String sellerId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('sellerId', isEqualTo: sellerId)
          .orderBy('date', descending: true)
          .get();

      final sales = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()).toEntity())
          .toList();
      return Right(sales);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status.name,
      });
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
