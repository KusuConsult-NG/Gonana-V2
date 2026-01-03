import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

import '../../data/models/logistics_model.dart';

// Events
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final ProductEntity product;
  const AddToCart(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final ProductEntity product;
  const RemoveFromCart(this.product);
  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}

class SelectLogistics extends CartEvent {
  final LogisticsModel logistics;
  const SelectLogistics(this.logistics);
  @override
  List<Object> get props => [logistics];
}

// State
class CartState extends Equatable {
  final List<ProductEntity> items;
  final LogisticsModel? selectedLogistics;
  final List<LogisticsModel> logisticsOptions;

  const CartState({
    this.items = const [],
    this.selectedLogistics,
    this.logisticsOptions = const [],
  });

  double get totalAmount {
    double itemTotal = 0;
    bool needsLogistics = false;

    for (final item in items) {
      itemTotal += item.amount;
      if (item.shippingPrice != null) {
        itemTotal += item.shippingPrice!;
      } else {
        needsLogistics = true;
      }
    }

    if (needsLogistics && selectedLogistics != null) {
      itemTotal += selectedLogistics!.price;
    }
    return itemTotal;
  }

  @override
  List<Object?> get props => [items, selectedLogistics, logisticsOptions];

  CartState copyWith({
    List<ProductEntity>? items,
    LogisticsModel? selectedLogistics,
    List<LogisticsModel>? logisticsOptions,
  }) {
    return CartState(
      items: items ?? this.items,
      selectedLogistics: selectedLogistics ?? this.selectedLogistics,
      logisticsOptions: logisticsOptions ?? this.logisticsOptions,
    );
  }
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
    : super(
        const CartState(
          logisticsOptions: [
            LogisticsModel(
              id: '1',
              name: 'GIG Logistics',
              price: 2500,
              estimatedDelivery: '2-3 Days',
            ),
            LogisticsModel(
              id: '2',
              name: 'DHL Express',
              price: 5000,
              estimatedDelivery: '1 Day',
            ),
            LogisticsModel(
              id: '3',
              name: 'Standard Delivery',
              price: 1500,
              estimatedDelivery: '4-5 Days',
            ),
          ],
        ),
      ) {
    on<AddToCart>((event, emit) {
      final updatedItems = List<ProductEntity>.from(state.items)
        ..add(event.product);
      emit(state.copyWith(items: updatedItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = List<ProductEntity>.from(state.items)
        ..remove(event.product);
      emit(state.copyWith(items: updatedItems));
    });

    on<ClearCart>((event, emit) {
      emit(state.copyWith(items: []));
    });

    on<SelectLogistics>((event, emit) {
      emit(state.copyWith(selectedLogistics: event.logistics));
    });
  }
}
