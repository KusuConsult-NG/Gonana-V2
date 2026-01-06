import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/staking_pool_entity.dart';
import '../../domain/entities/user_stake_entity.dart';
import '../../domain/repositories/staking_repository.dart';
import '../models/staking_pool_model.dart';
import '../models/user_stake_model.dart';

@LazySingleton(as: StakingRepository)
class StakingRepositoryImpl implements StakingRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  StakingRepositoryImpl(this._firestore, this._auth);

  @override
  Future<Either<String, List<StakingPoolEntity>>> getPools() async {
    try {
      final snapshot = await _firestore.collection('staking_pools').get();
      final pools = snapshot.docs
          .map((doc) => StakingPoolModel.fromFirestore(doc))
          .toList();
      return Right(pools);
    } catch (e) {
      return Left('Failed to fetch staking pools: $e');
    }
  }

  @override
  Future<Either<String, List<UserStakeEntity>>> getUserStakes() async {
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('stakes')
          .get();

      final stakes = snapshot.docs
          .map((doc) => UserStakeModel.fromFirestore(doc))
          .toList();
      return Right(stakes);
    } catch (e) {
      return Left('Failed to fetch user stakes: $e');
    }
  }

  @override
  Future<Either<String, void>> stakeTokens({
    required String poolId,
    required double amount,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      // Fetch pool info for name and returns
      final poolDoc = await _firestore
          .collection('staking_pools')
          .doc(poolId)
          .get();
      if (!poolDoc.exists) return const Left('Staking pool not found');

      final poolData = poolDoc.data()!;
      final double apy = (poolData['apy'] as num).toDouble();
      final String durationStr = poolData['duration'] as String;

      // Calculate end date based on duration string (e.g., "30 Days")
      final days = int.tryParse(durationStr.split(' ')[0]) ?? 30;
      final endDate = DateTime.now().add(Duration(days: days));

      final expectedReturn = amount * (apy / 100) * (days / 365);

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('stakes')
          .add({
            'poolId': poolId,
            'poolName': poolData['name'],
            'amount': amount,
            'startDate': FieldValue.serverTimestamp(),
            'endDate': Timestamp.fromDate(endDate),
            'expectedReturn': expectedReturn,
          });

      // Deduct from wallet
      await _firestore.collection('users').doc(user.uid).update({
        'walletBalance': FieldValue.increment(-amount),
      });

      return const Right(null);
    } catch (e) {
      return Left('Failed to stake: $e');
    }
  }
}
