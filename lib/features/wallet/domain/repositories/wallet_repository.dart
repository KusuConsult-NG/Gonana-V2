import '../entities/transaction_entity.dart';
import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<WalletEntity> getWalletBalance();
  Future<List<TransactionEntity>> getTransactions();
}
