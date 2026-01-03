import 'package:dartz/dartz.dart';
import '../entities/review_entity.dart';
import '../entities/product_entity.dart';
import 'dart:io';

abstract class MarketRepository {
  Future<Either<String, List<ProductEntity>>> getProducts();
  Future<Either<String, List<ProductEntity>>> getHotDeals();
  Future<Either<String, List<ProductEntity>>> searchProducts(String query);
  Future<Either<String, List<ProductEntity>>> getSellerProducts(
    String sellerId,
  );
  Future<Either<String, void>> deleteProduct(String productId);
  Future<Either<String, void>> createProduct({
    required String name,
    required double price,
    required String description,
    required String location,
    required double availableQuantity,
    required String unit,
    double? shippingPrice,
    List<File> images = const [],
  });
  Future<Either<String, void>> addReview(ReviewEntity review);
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
    String productId,
  );
}
