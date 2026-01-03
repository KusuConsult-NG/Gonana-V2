import 'package:dartz/dartz.dart';
import '../entities/staking_pool_entity.dart';
import '../entities/user_stake_entity.dart';

abstract class StakingRepository {
  Future<Either<String, List<StakingPoolEntity>>> getPools();
  Future<Either<String, List<UserStakeEntity>>> getUserStakes();
  Future<Either<String, void>> stakeTokens({
    required String poolId,
    required double amount,
  });
}
