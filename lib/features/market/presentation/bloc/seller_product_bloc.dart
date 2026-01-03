import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/market_repository.dart';
import 'seller_product_event.dart';
import 'seller_product_state.dart';

@injectable
class SellerProductBloc extends Bloc<SellerProductEvent, SellerProductState> {
  final MarketRepository _repository;
  final FirebaseAuth _auth;

  SellerProductBloc(this._repository, this._auth)
    : super(const SellerProductState.initial()) {
    on<SellerProductEvent>((event, emit) async {
      await event.map(
        loadMyProducts: (_) async {
          emit(const SellerProductState.loading());
          final user = _auth.currentUser;
          if (user == null) {
            emit(const SellerProductState.error('User not logged in'));
            return;
          }

          final result = await _repository.getSellerProducts(user.uid);
          result.fold(
            (error) => emit(SellerProductState.error(error)),
            (products) => emit(SellerProductState.loaded(products)),
          );
        },
        deleteProduct: (e) async {
          emit(const SellerProductState.loading());
          final result = await _repository.deleteProduct(e.productId);
          result.fold((error) => emit(SellerProductState.error(error)), (_) {
            emit(
              const SellerProductState.success('Product deleted successfully'),
            );
            add(const SellerProductEvent.loadMyProducts());
          });
        },
      );
    });
  }
}
