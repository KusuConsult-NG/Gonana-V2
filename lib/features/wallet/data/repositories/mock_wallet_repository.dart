import '../../domain/entities/wallet_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/wallet_repository.dart';

// @LazySingleton(as: WalletRepository)
class MockWalletRepository implements WalletRepository {
  @override
  Future<void> debitWallet(double amount) async {
    // Mock debit
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<WalletEntity> getWalletBalance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const WalletEntity(
      balanceNgn: 154500.00,
      cryptoBalanceCcd: 1250.50,
      cryptoBalanceEth: 0.45,
    );
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TransactionEntity(
        id: '1',
        amount: 50000,
        description: 'Deposit via Bank Transfer',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      ),
      TransactionEntity(
        id: '2',
        amount: 12000,
        description: 'Purchase of Maize Seeds',
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: TransactionType.debit,
        status: TransactionStatus.completed,
      ),
      TransactionEntity(
        id: '3',
        amount: 25000,
        description: 'Logistics Payment',
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: TransactionType.debit,
        status: TransactionStatus.completed,
      ),
    ];
  }
}
