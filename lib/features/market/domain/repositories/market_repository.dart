import '../entities/product_entity.dart';

abstract class MarketRepository {
  Future<List<ProductEntity>> getProducts();
  Future<List<ProductEntity>> getHotDeals();
  Future<List<ProductEntity>> searchProducts(String query);
}
