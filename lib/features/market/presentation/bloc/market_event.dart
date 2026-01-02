part of 'market_bloc.dart';

@freezed
class MarketEvent with _$MarketEvent {
  const factory MarketEvent.loadData() = _LoadData;
  const factory MarketEvent.searchProducts(String query) = _SearchProducts;
}
