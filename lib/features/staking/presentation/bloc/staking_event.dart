import 'package:freezed_annotation/freezed_annotation.dart';

part 'staking_event.freezed.dart';

@freezed
class StakingEvent with _$StakingEvent {
  const factory StakingEvent.started() = _Started;
  const factory StakingEvent.stakeTokens({
    required String poolId,
    required double amount,
  }) = _StakeTokens;
}
