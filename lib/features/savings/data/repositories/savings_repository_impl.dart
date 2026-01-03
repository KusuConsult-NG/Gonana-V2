import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/savings_asset_entity.dart';
import '../../domain/entities/user_savings_entity.dart';
import '../../domain/repositories/savings_repository.dart';
import '../models/savings_asset_model.dart';
import '../models/user_savings_model.dart';

@LazySingleton(as: SavingsRepository)
class SavingsRepositoryImpl implements SavingsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SavingsRepositoryImpl(this._firestore, this._auth);

  @override
  Future<Either<String, List<SavingsAssetEntity>>> getSavingsAssets() async {
    try {
      final snapshot = await _firestore.collection('savings_assets').get();
      final assets = snapshot.docs
          .map((doc) => SavingsAssetModel.fromFirestore(doc))
          .toList();
      return Right(assets);
    } catch (e) {
      return Left('Failed to fetch savings assets: $e');
    }
  }

  @override
  Future<Either<String, List<UserSavingsEntity>>> getUserSavings() async {
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('savings')
          .get();

      final savings = snapshot.docs
          .map((doc) => UserSavingsModel.fromFirestore(doc))
          .toList();
      return Right(savings);
    } catch (e) {
      return Left('Failed to fetch user savings: $e');
    }
  }

  @override
  Future<Either<String, void>> fundSavings({
    required String assetId,
    required double amount,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      final userSavingsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('savings')
          .doc(assetId);

      final doc = await userSavingsRef.get();

      if (doc.exists) {
        await userSavingsRef.update({'balance': FieldValue.increment(amount)});
      } else {
        // Fetch asset info to store name
        final assetDoc = await _firestore
            .collection('savings_assets')
            .doc(assetId)
            .get();
        final assetData = assetDoc.data();

        await userSavingsRef.set({
          'assetId': assetId,
          'assetName': assetData?['name'] ?? 'Asset',
          'balance': amount,
          'accruedProfit': 0.0,
          'startDate': FieldValue.serverTimestamp(),
        });
      }

      // Also deduct from wallet balance (Logic should be here or in a service)
      await _firestore.collection('users').doc(user.uid).update({
        'walletBalance': FieldValue.increment(-amount),
      });

      return const Right(null);
    } catch (e) {
      return Left('Failed to fund savings: $e');
    }
  }
}
