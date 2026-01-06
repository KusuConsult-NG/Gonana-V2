import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';
import '../../../../core/services/blockchain_service.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final BlockchainService _blockchainService;

  WalletRepositoryImpl(this._auth, this._firestore, this._blockchainService);

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

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  WalletEntity? _cachedWallet;

  @override
  Future<void> debitWallet(double amount) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    try {
      final docRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('wallet')
          .doc('balance');

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Wallet not found');
        }

        final currentBalance = snapshot.data()?['balanceNgn'] as double? ?? 0.0;
        if (currentBalance >= amount) {
          transaction.update(docRef, {'balanceNgn': currentBalance - amount});
        } else {
          throw Exception('Insufficient funds');
        }
      });
      // Invalidate cache
      _cachedWallet = null;
    } catch (e) {
      throw Exception('Debit failed: $e');
    }
  }

  @override
  Future<WalletEntity> getWalletBalance() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    if (_cachedWallet != null) return _cachedWallet!;

    try {
      final walletRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('wallet')
          .doc('balance');

      final doc = await walletRef.get();

      if (doc.exists && doc.data() != null) {
        _cachedWallet = WalletModel.fromFirestore(doc);
        return _cachedWallet!;
      } else {
        // Create new wallet if it doesn't exist
        return await _createWallet(uid);
      }
    } catch (e) {
      // On error, attempt creation or re-fetch to be robust, or throw
      // For now, assume if we can't fetch, we can't create, so throw.
      throw Exception('Failed to fetch/create wallet: $e');
    }
  }

  Future<WalletEntity> _createWallet(String uid) async {
    try {
      // Generate real wallet using blockchain service
      final walletData = _blockchainService.generateWallet();

      // Encrypt sensitive data
      final encryptedMnemonic = _blockchainService.encryptData(
        walletData['mnemonic'],
      );
      final encryptedSeed = _blockchainService.encryptData(walletData['seed']);

      // Get addresses
      final addresses = walletData['addresses'] as Map<String, String>;

      // Create wallet model with real addresses
      final newWallet = WalletModel(
        balanceNgn: 0.0,
        cryptoBalanceCcd: 0.0,
        cryptoBalanceEth: 0.0,
        virtualAccountNumber: 'Generating...',
        bankName: 'Providus Bank',
        isKycVerified: false,
        cryptoAddresses: {'CCD': '', 'ETH': addresses['Ethereum'] ?? ''},
        multiChainAddresses: addresses,
        encryptedMnemonic: encryptedMnemonic,
        encryptedSeed: encryptedSeed,
        currentChain: 'Ethereum',
      );

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallet')
          .doc('balance')
          .set(newWallet.toJson());

      _cachedWallet = newWallet;
      return newWallet;
    } catch (e) {
      throw Exception('Failed to create wallet: $e');
    }
  }
}
