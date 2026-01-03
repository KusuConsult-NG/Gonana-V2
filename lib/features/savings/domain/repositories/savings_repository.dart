import 'package:dartz/dartz.dart';
import '../entities/savings_asset_entity.dart';
import '../entities/user_savings_entity.dart';

abstract class SavingsRepository {
  Future<Either<String, List<SavingsAssetEntity>>> getSavingsAssets();
  Future<Either<String, List<UserSavingsEntity>>> getUserSavings();
  Future<Either<String, void>> fundSavings({
    required String assetId,
    required double amount,
  });
}
