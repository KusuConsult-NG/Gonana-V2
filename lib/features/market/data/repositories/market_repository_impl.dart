import 'package:injectable/injectable.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../models/product_model.dart';

@LazySingleton(as: MarketRepository)
@LazySingleton(as: MarketRepository)
class MarketRepositoryImpl implements MarketRepository {
  MarketRepositoryImpl();

  // Mock Agricultural Data
  final List<ProductModel> _mockProducts = [
    const ProductModel(
      id: 'rice-1',
      title: 'Premium Parboiled Rice',
      amount: 45000,
      imageUrl:
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&q=80',
      description: 'High quality long grain parboiled rice, 50kg bag.',
      isHotDeal: true,
      discountPercentage: 10,
    ),
    const ProductModel(
      id: 'yam-1',
      title: 'Benue Yams (Large Tubers)',
      amount: 12000,
      imageUrl:
          'https://images.unsplash.com/photo-1593106295287-21a7196395b8?auto=format&fit=crop&q=80',
      description: 'Fresh large tuber yams from Benue, sold in sets of 5.',
      isHotDeal: true,
    ),
    const ProductModel(
      id: 'oil-1',
      title: 'Red Palm Oil (25 Liters)',
      amount: 28000,
      imageUrl:
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&q=80',
      description: 'Pure unadulterated red palm oil, perfect for cooking.',
      isHotDeal: false,
    ),
    const ProductModel(
      id: 'beans-1',
      title: 'Honey Beans (Oloyin)',
      amount: 15000,
      imageUrl:
          'https://images.unsplash.com/photo-1551462147-37885acc36f1?auto=format&fit=crop&q=80',
      description: 'Clean picked honey beans, 10kg bag.',
      isHotDeal: false, // Changed to false to test filter
      discountPercentage: 5, // But has discount
    ),
    const ProductModel(
      id: 'onion-1',
      title: 'Red Onions (Basket)',
      amount: 18000,
      imageUrl:
          'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?auto=format&fit=crop&q=80',
      description: 'Full basket of fresh red onions.',
      isHotDeal: true,
      discountPercentage: 15,
    ),
  ];

  @override
  Future<List<ProductEntity>> getHotDeals() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockProducts
        .where(
          (p) =>
              p.isHotDeal ||
              (p.discountPercentage != null && p.discountPercentage! > 0),
        )
        .toList();
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockProducts;
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProducts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
