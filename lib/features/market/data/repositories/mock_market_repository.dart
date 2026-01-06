import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
// import 'package:injectable/injectable.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/market_repository.dart';

// @LazySingleton(as: MarketRepository)
// @LazySingleton(as: MarketRepository)
class MockMarketRepository implements MarketRepository {
  // In-memory mock data
  final List<ProductEntity> _mockProducts = [
    const ProductEntity(
      id: '1',
      title: 'Fresh Organic Tomatoes',
      description:
          'Locally grown, pesticide-free organic tomatoes. Perfect for salads and cooking.',
      amount: 1500.0,
      images: [
        'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&q=80&w=1000',
      ],
      location: 'Abuja, Nigeria',
      sellerId: 'seller1',
      sellerName: 'Green Earth Farms',
      quantity: 50,
      isHotDeal: true,
      shippingMethods: ['Delivery', 'Pickup'],
    ),
    const ProductEntity(
      id: '2',
      title: 'Premium Brown Rice',
      description:
          'High-quality brown rice, rich in fiber and nutrients. 50kg bag.',
      amount: 45000.0,
      images: [
        'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&q=80&w=1000',
      ],
      location: 'Lagos, Nigeria',
      sellerId: 'seller2',
      sellerName: 'Naija Grains',
      quantity: 100,
      isHotDeal: true,
      shippingMethods: ['Delivery'],
    ),
    const ProductEntity(
      id: '3',
      title: 'Yellow Maize',
      description:
          'Dried yellow maize, suitable for animal feed or processing.',
      amount: 12000.0,
      images: [
        'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&q=80&w=1000',
      ],
      location: 'Kano, Nigeria',
      sellerId: 'seller3',
      sellerName: 'Northern Harvest',
      quantity: 200,
      isHotDeal: false,
    ),
    const ProductEntity(
      id: '4',
      title: 'Red Palm Oil',
      description: 'Pure, unadulterated red palm oil. 25 Litre keg.',
      amount: 28000.0,
      images: [
        'https://images.unsplash.com/photo-1620662706375-8f71d5b9b28f?auto=format&fit=crop&q=80&w=1000',
      ],
      location: 'Enugu, Nigeria',
      sellerId: 'seller4',
      sellerName: 'Eastern Oils',
      quantity: 30,
      isHotDeal: false,
    ),
    const ProductEntity(
      id: '5',
      title: 'Irish Potatoes',
      description:
          'Fresh Irish potatoes from Jos. Great for chips and boiling.',
      amount: 8000.0,
      images: [
        'https://images.unsplash.com/photo-1518977676601-b53f82a6b696?auto=format&fit=crop&q=80&w=1000',
      ],
      location: 'Jos, Nigeria',
      sellerId: 'seller5',
      sellerName: 'Plateau Farms',
      quantity: 150,
      isHotDeal: false,
    ),
  ];

  @override
  Future<Either<String, List<ProductEntity>>> getHotDeals() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Right(_mockProducts.where((p) => p.isHotDeal).toList());
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Right(_mockProducts);
  }

  @override
  Future<Either<String, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lowercaseQuery = query.toLowerCase();
    final results = _mockProducts.where((p) {
      return p.title.toLowerCase().contains(lowercaseQuery) ||
          p.description.toLowerCase().contains(lowercaseQuery) ||
          (p.location?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
    return Right(results);
  }

  @override
  Future<Either<String, List<ProductEntity>>> getSellerProducts(
    String sellerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // In strict mock mode, we might just return all or filter by a dummy ID
    // For demo purposes, let's just return a subset
    return Right(_mockProducts.take(2).toList());
  }

  @override
  Future<Either<String, void>> deleteProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockProducts.removeWhere((p) => p.id == productId);
    return const Right(null);
  }

  @override
  Future<Either<String, void>> createProduct({
    required String name,
    required double price,
    required String description,
    required String location,
    required double availableQuantity,
    required String unit,
    double? shippingPrice,
    List<File> images = const [],
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final newProduct = ProductEntity(
      id: const Uuid().v4(),
      title: name,
      description: description,
      amount: price,
      images: images.isNotEmpty ? ['https://via.placeholder.com/300'] : [],
      location: location,
      quantity: 1,
      availableQuantity: availableQuantity,
      unit: unit,
      isHotDeal: false,
      discountPercentage: null,
      shippingMethods: shippingPrice != null
          ? const ['Farmer Shipping']
          : const ['Logistics Company'],
      sellerId: 'user_123',
      sellerName: 'John Doe',
      sellerPhoto: null,
      shippingPrice: shippingPrice,
    );

    _mockProducts.insert(0, newProduct);
    return const Right(null);
  }

  final List<ReviewEntity> _mockReviews = [];

  @override
  Future<Either<String, void>> addReview(ReviewEntity review) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockReviews.add(review);
    return const Right(null);
  }

  @override
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
    String productId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(
      _mockReviews.where((r) => r.productId == productId).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  @override
  Future<Either<String, void>> decrementProductStock(
    String productId,
    double quantity,
  ) async {
    try {
      final index = _mockProducts.indexWhere((p) => p.id == productId);
      if (index != -1) {
        final product = _mockProducts[index];
        final currentStock = product.availableQuantity ?? 0;
        final newStock = currentStock - quantity;

        _mockProducts[index] = product.copyWith(
          availableQuantity: newStock < 0 ? 0 : newStock,
        );
        return const Right(null);
      }
      return const Left('Product not found'); // Or just ignore for mock
    } catch (e) {
      return Left('Failed to update mock stock: $e');
    }
  }
}
