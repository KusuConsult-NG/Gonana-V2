import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
import '../../domain/entities/staking_pool_entity.dart';
import '../../domain/entities/user_stake_entity.dart';
import '../../domain/repositories/staking_repository.dart';

// @LazySingleton(as: StakingRepository)
class MockStakingRepository implements StakingRepository {
  final List<UserStakeEntity> _userStakes = [
    UserStakeEntity(
      id: 'st1',
      poolId: 'p1',
      poolName: 'Maize Liquidity Pool',
      amount: 100000,
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 15)),
      expectedReturn: 5000,
    ),
  ];

  @override
  Future<Either<String, List<StakingPoolEntity>>> getPools() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right([
      StakingPoolEntity(
        id: 'p1',
        name: 'Maize Liquidity Pool',
        apy: 15.0,
        duration: '30 Days',
        minStakingAmount: 50000,
      ),
      StakingPoolEntity(
        id: 'p2',
        name: 'Rice Expansion Fund',
        apy: 18.5,
        duration: '90 Days',
        minStakingAmount: 100000,
      ),
    ]);
  }

  @override
  Future<Either<String, List<UserStakeEntity>>> getUserStakes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(_userStakes);
  }

  @override
  Future<Either<String, void>> stakeTokens({
    required String poolId,
    required double amount,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock Stake
    _userStakes.add(
      UserStakeEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        poolId: poolId,
        poolName: poolId == 'p1'
            ? 'Maize Liquidity Pool'
            : 'Rice Expansion Fund',
        amount: amount,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        expectedReturn: amount * 0.15 * (30 / 365),
      ),
    );
    return const Right(null);
  }
}
