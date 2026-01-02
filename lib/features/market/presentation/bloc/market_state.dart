part of 'market_bloc.dart';

@freezed
class MarketState with _$MarketState {
  const factory MarketState.initial() = _Initial;
  const factory MarketState.loading() = _Loading;
  const factory MarketState.loaded({
    required List<ProductEntity> products,
    required List<ProductEntity> hotDeals,
  }) = _Loaded;
  const factory MarketState.error(String message) = _Error;
}
