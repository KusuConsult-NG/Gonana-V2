import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/staking_repository.dart';
import 'staking_event.dart';
import 'staking_state.dart';

@injectable
class StakingBloc extends Bloc<StakingEvent, StakingState> {
  final StakingRepository _repository;

  StakingBloc(this._repository) : super(const StakingState.initial()) {
    on<StakingEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const StakingState.loading());
          final poolsResult = await _repository.getPools();
          final userStakesResult = await _repository.getUserStakes();

          poolsResult.fold((error) => emit(StakingState.error(error)), (pools) {
            userStakesResult.fold(
              (error) => emit(StakingState.error(error)),
              (userStakes) => emit(
                StakingState.loaded(pools: pools, userStakes: userStakes),
              ),
            );
          });
        },
        stakeTokens: (e) async {
          emit(const StakingState.loading());
          final result = await _repository.stakeTokens(
            poolId: e.poolId,
            amount: e.amount,
          );

          result.fold((error) => emit(StakingState.error(error)), (_) {
            emit(const StakingState.success('Tokens successfully staked'));
            add(const StakingEvent.started()); // Refresh data
          });
        },
      );
    });
  }
}
