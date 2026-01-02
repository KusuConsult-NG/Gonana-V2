import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/market_repository.dart';
import 'package:injectable/injectable.dart';

part 'market_event.dart';
part 'market_state.dart';
part 'market_bloc.freezed.dart';

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository _marketRepository;

  MarketBloc(this._marketRepository) : super(const MarketState.initial()) {
    on<_LoadData>(_onLoadData);
    on<_SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadData(_LoadData event, Emitter<MarketState> emit) async {
    emit(const MarketState.loading());
    try {
      final hotDeals = await _marketRepository.getHotDeals();
      final products = await _marketRepository.getProducts();
      emit(MarketState.loaded(products: products, hotDeals: hotDeals));
    } catch (e) {
      emit(MarketState.error(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<MarketState> emit,
  ) async {
    // Keep current data if possible, or show loading overlay
    // For simplicity, we might just emit loading or a specific search loading state
    // But let's assume we want to filter the current loaded state or fetch new
    try {
      final results = await _marketRepository.searchProducts(event.query);
      // If we want to maintain the hot deals, we need to know them.
      // Simplified: Just update the products list with search results
      final hotDeals = await _marketRepository
          .getHotDeals(); // Re-fetch or cache
      emit(MarketState.loaded(products: results, hotDeals: hotDeals));
    } catch (e) {
      emit(MarketState.error(e.toString()));
    }
  }
}
