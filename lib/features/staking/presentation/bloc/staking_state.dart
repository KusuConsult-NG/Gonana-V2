import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/staking_pool_entity.dart';
import '../../domain/entities/user_stake_entity.dart';

part 'staking_state.freezed.dart';

@freezed
class StakingState with _$StakingState {
  const factory StakingState.initial() = _Initial;
  const factory StakingState.loading() = _Loading;
  const factory StakingState.loaded({
    required List<StakingPoolEntity> pools,
    required List<UserStakeEntity> userStakes,
  }) = _Loaded;
  const factory StakingState.success(String message) = _Success;
  const factory StakingState.error(String message) = _Error;
}
