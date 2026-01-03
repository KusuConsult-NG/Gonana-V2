import 'package:dartz/dartz.dart';
import '../../domain/entities/savings_asset_entity.dart';
import '../../domain/entities/user_savings_entity.dart';
import '../../domain/repositories/savings_repository.dart';

// @LazySingleton(as: SavingsRepository)
class MockSavingsRepository implements SavingsRepository {
  final List<UserSavingsEntity> _userSavings = [
    UserSavingsEntity(
      id: 's1',
      assetId: '1',
      assetName: 'SafeLock (Agro)',
      balance: 50000,
      accruedProfit: 1200,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      nextPayoutDate: DateTime.now().add(const Duration(days: 60)),
    ),
  ];

  @override
  Future<Either<String, List<SavingsAssetEntity>>> getSavingsAssets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right([
      SavingsAssetEntity(
        id: '1',
        name: 'SafeLock (Agro)',
        icon: 'assets/icons/safelock.png',
        apy: 12.5,
        minDuration: '3 Months',
        description: 'Lock funds for agricultural investments.',
      ),
      SavingsAssetEntity(
        id: '2',
        name: 'Flex Save',
        icon: 'assets/icons/flex.png',
        apy: 8.0,
        minDuration: 'Anytime',
        description: 'Flexible savings with daily interest.',
      ),
    ]);
  }

  @override
  Future<Either<String, List<UserSavingsEntity>>> getUserSavings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(_userSavings);
  }

  @override
  Future<Either<String, void>> fundSavings({
    required String assetId,
    required double amount,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Find existing to update or add new
    final existingIndex = _userSavings.indexWhere((s) => s.assetId == assetId);
    if (existingIndex != -1) {
      final existing = _userSavings[existingIndex];
      _userSavings[existingIndex] = UserSavingsEntity(
        id: existing.id,
        assetId: existing.assetId,
        assetName: existing.assetName,
        balance: existing.balance + amount,
        accruedProfit: existing.accruedProfit,
        startDate: existing.startDate,
        nextPayoutDate: existing.nextPayoutDate,
      );
    } else {
      _userSavings.add(
        UserSavingsEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          assetId: assetId,
          assetName: assetId == '1' ? 'SafeLock (Agro)' : 'Flex Save',
          balance: amount,
          accruedProfit: 0,
          startDate: DateTime.now(),
        ),
      );
    }
    return const Right(null);
  }
}
