import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/market_repository.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

part 'market_event.dart';
part 'market_state.dart';
part 'market_bloc.freezed.dart';

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository _marketRepository;

  MarketBloc(this._marketRepository) : super(const MarketState.initial()) {
    on<_LoadData>(_onLoadData);
    on<_SearchProducts>(_onSearchProducts);
    on<_CreateProduct>(_onCreateProduct);
  }

  Future<void> _onLoadData(_LoadData event, Emitter<MarketState> emit) async {
    emit(const MarketState.loading());
    final hotDealsResult = await _marketRepository.getHotDeals();
    final productsResult = await _marketRepository.getProducts();

    hotDealsResult.fold((error) => emit(MarketState.error(error)), (hotDeals) {
      productsResult.fold(
        (error) => emit(MarketState.error(error)),
        (products) =>
            emit(MarketState.loaded(hotDeals: hotDeals, products: products)),
      );
    });
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<MarketState> emit,
  ) async {
    emit(const MarketState.loading());
    final searchResult = await _marketRepository.searchProducts(event.query);
    final hotDealsResult = await _marketRepository.getHotDeals();

    searchResult.fold((error) => emit(MarketState.error(error)), (
      searchResults,
    ) {
      hotDealsResult.fold(
        (error) => emit(MarketState.error(error)),
        (hotDeals) => emit(
          MarketState.loaded(hotDeals: hotDeals, products: searchResults),
        ),
      );
    });
  }

  Future<void> _onCreateProduct(
    _CreateProduct event,
    Emitter<MarketState> emit,
  ) async {
    emit(const MarketState.loading());
    final result = await _marketRepository.createProduct(
      name: event.name,
      price: event.price,
      description: event.description,
      location: event.location,
      availableQuantity: event.availableQuantity,
      unit: event.unit,
      shippingPrice: event.shippingPrice,
      images: event.images,
    );

    result.fold(
      (error) => emit(MarketState.error(error)),
      (_) => add(const MarketEvent.loadData()),
    );
  }
}
