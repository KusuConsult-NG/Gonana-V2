import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/order_repository.dart';
import '../../../../core/services/notification_service.dart';
import 'order_event.dart';
import 'order_state.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _repository;
  final NotificationService _notificationService;

  OrderBloc(this._repository, this._notificationService)
    : super(const OrderState.initial()) {
    on<LoadBuyerOrders>(_onLoadBuyerOrders);
    on<LoadSellerSales>(_onLoadSellerSales);
    on<CreateOrder>(_onCreateOrder);
    on<UpdateStatus>(_onUpdateStatus);
  }

  Future<void> _onLoadBuyerOrders(
    LoadBuyerOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderState.loading());
    final result = await _repository.getBuyerOrders(event.buyerId);
    result.fold(
      (failure) => emit(OrderState.error(failure.toString())),
      (orders) => emit(OrderState.loaded(orders: orders)),
    );
  }

  Future<void> _onLoadSellerSales(
    LoadSellerSales event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderState.loading());
    final result = await _repository.getSellerSales(event.sellerId);
    result.fold(
      (failure) => emit(OrderState.error(failure.toString())),
      (sales) => emit(OrderState.loaded(sales: sales)),
    );
  }

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderState.loading());
    final result = await _repository.createOrder(event.order);
    result.fold((failure) => emit(OrderState.error(failure.toString())), (_) {
      _notificationService.showNotification(
        title: 'Order Placed!',
        body: 'Your order for ${event.order.productName} has been received.',
      );
      emit(const OrderState.success());
    });
  }

  Future<void> _onUpdateStatus(
    UpdateStatus event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _repository.updateOrderStatus(
      event.orderId,
      event.status,
    );
    result.fold(
      (failure) => emit(OrderState.error(failure.toString())),
      (_) => add(
        LoadSellerSales(
          state.maybeWhen(
            loaded: (_, sales) =>
                sales.first.sellerId, // Simple way to refresh current view
            orElse: () => '',
          ),
        ),
      ),
    );
  }
}
