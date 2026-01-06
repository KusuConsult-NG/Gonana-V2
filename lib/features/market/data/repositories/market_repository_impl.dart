import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import '../../domain/repositories/market_repository.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/review_entity.dart';
import 'dart:io';

@LazySingleton(as: MarketRepository)
class MarketRepositoryImpl implements MarketRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  MarketRepositoryImpl(this._firestore, this._storage, this._auth);

  @override
  Future<Either<String, List<ProductEntity>>> getHotDeals() async {
    try {
      final snapshot = await _firestore.collection('products').limit(5).get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      return Right(products);
    } catch (e) {
      return Left('Failed to fetch hot deals: $e');
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      return Right(products);
    } catch (e) {
      return Left('Failed to fetch products: $e');
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      return Right(products);
    } catch (e) {
      return Left('Search failed: $e');
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getSellerProducts(
    String sellerId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('sellerId', isEqualTo: sellerId)
          .get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      return Right(products);
    } catch (e) {
      return Left('Failed to fetch seller products: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete product: $e');
    }
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
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      final List<String> imageUrls = [];

      // Upload images to Firebase Storage with better error handling
      for (var i = 0; i < images.length; i++) {
        try {
          final image = images[i];
          final ref = _storage
              .ref()
              .child('products')
              .child('${DateTime.now().millisecondsSinceEpoch}_$i.jpg');

          // Upload file
          final uploadTask = await ref.putFile(image);

          // Verify upload was successful
          if (uploadTask.state != TaskState.success) {
            return const Left(
              'Image upload failed. Please check your connection and try again.',
            );
          }

          // Get download URL
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        } catch (storageError) {
          // Handle specific Firebase Storage errors
          if (storageError.toString().contains('object-not-found')) {
            return const Left(
              'Storage configuration error. Please contact support.',
            );
          } else if (storageError.toString().contains('unauthorized')) {
            return const Left(
              'You do not have permission to upload images. Please log in again.',
            );
          } else {
            return Left(
              'Failed to upload image ${i + 1}: ${storageError.toString()}',
            );
          }
        }
      }

      // Fetch seller profile info
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final userData = userDoc.data();
      final sellerName = userData != null
          ? '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                .trim()
          : 'Seller';
      final sellerPhoto = userData?['profilePhoto'] as String?;

      final product = ProductModel(
        id: '', // Firestore will generate
        title: name,
        amount: price,
        description: description,
        images: imageUrls,
        availableQuantity: availableQuantity,
        unit: unit,
        quantity: 1, // Default cart quantity
        location: location,
        sellerId: user.uid,
        sellerName: sellerName,
        sellerPhoto: sellerPhoto,
        shippingPrice: shippingPrice,
      );

      await _firestore.collection('products').add(product.toJson());
      return const Right(null);
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      return Left('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      return Left('Failed to create product: $e');
    }
  }

  @override
  Future<Either<String, void>> addReview(ReviewEntity review) async {
    try {
      final reviewModel = ReviewModel(
        id: review.id,
        productId: review.productId,
        userId: review.userId,
        userName: review.userName,
        userPhoto: review.userPhoto,
        rating: review.rating,
        comment: review.comment,
        createdAt: review.createdAt,
      );

      await _firestore.runTransaction((transaction) async {
        final productRef = _firestore
            .collection('products')
            .doc(review.productId);
        final reviewRef = productRef.collection('reviews').doc();

        // Get current product state
        final productSnapshot = await transaction.get(productRef);
        if (!productSnapshot.exists) {
          throw Exception('Product does not exist');
        }

        final productData = productSnapshot.data() as Map<String, dynamic>;
        final currentRating =
            (productData['rating'] as num?)?.toDouble() ?? 0.0;
        final currentCount = (productData['reviewCount'] as num?)?.toInt() ?? 0;

        // Calculate new rating
        final newCount = currentCount + 1;
        final newRating =
            ((currentRating * currentCount) + review.rating) / newCount;

        // Update product
        transaction.update(productRef, {
          'rating': newRating,
          'reviewCount': newCount,
        });

        // Add review
        transaction.set(reviewRef, reviewModel.toJson());
      });

      return const Right(null);
    } catch (e) {
      return Left('Failed to add review: $e');
    }
  }

  @override
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
    String productId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .orderBy('createdAt', descending: true)
          .get();

      final reviews = snapshot.docs
          .map((doc) => ReviewModel.fromFirestore(doc))
          .toList();
      return Right(reviews);
    } catch (e) {
      return Left('Failed to fetch reviews: $e');
    }
  }

  @override
  Future<Either<String, void>> decrementProductStock(
    String productId,
    double quantity,
  ) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'availableQuantity': FieldValue.increment(-quantity),
      });
      return const Right(null);
    } catch (e) {
      return Left('Failed to update stock: $e');
    }
  }
}
