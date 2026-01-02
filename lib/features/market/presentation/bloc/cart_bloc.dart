import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

// Events
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
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

// State
class CartState extends Equatable {
  final List<ProductEntity> items;

  const CartState({this.items = const []});

  double get totalAmount => items.fold(0, (sum, item) => sum + item.amount);

  @override
  List<Object> get props => [items];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      final updatedItems = List<ProductEntity>.from(state.items)
        ..add(event.product);
      emit(CartState(items: updatedItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = List<ProductEntity>.from(state.items)
        ..remove(event.product);
      emit(CartState(items: updatedItems));
    });

    on<ClearCart>((event, emit) {
      emit(const CartState(items: []));
    });
  }
}
