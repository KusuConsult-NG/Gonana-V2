import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  WalletRepositoryImpl(this._auth, this._firestore);

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<WalletEntity> getWalletBalance() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return const WalletEntity(
        balanceNgn: 0,
        cryptoBalanceCcd: 0,
        cryptoBalanceEth: 0,
      );
    }

    try {
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallet')
          .doc('balance')
          .get();

      if (doc.exists && doc.data() != null) {
        return WalletModel.fromFirestore(doc);
      } else {
        // Return default/empty wallet if no data exists yet
        return const WalletEntity(
          balanceNgn: 0.0,
          cryptoBalanceCcd: 0.0,
          cryptoBalanceEth: 0.0,
        );
      }
    } catch (e) {
      // In case of error (e.g. offline), return default
      return const WalletEntity(
        balanceNgn: 0.0,
        cryptoBalanceCcd: 0.0,
        cryptoBalanceEth: 0.0,
      );
    }
  }
}
