part of 'market_bloc.dart';

@freezed
class MarketEvent with _$MarketEvent {
  const factory MarketEvent.loadData() = _LoadData;
  const factory MarketEvent.searchProducts(String query) = _SearchProducts;
  const factory MarketEvent.createProduct({
    required String name,
    required double price,
    required String description,
    required String location,
    required double availableQuantity,
    required String unit,
    double? shippingPrice,
    @Default([]) List<File> images,
  }) = _CreateProduct;
}
