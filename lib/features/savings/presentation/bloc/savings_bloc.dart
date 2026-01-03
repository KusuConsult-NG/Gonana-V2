import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/savings_repository.dart';
import 'savings_event.dart';
import 'savings_state.dart';

@injectable
class SavingsBloc extends Bloc<SavingsEvent, SavingsState> {
  final SavingsRepository _repository;

  SavingsBloc(this._repository) : super(const SavingsState.initial()) {
    on<SavingsEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const SavingsState.loading());
          final assetsResult = await _repository.getSavingsAssets();
          final userSavingsResult = await _repository.getUserSavings();

          assetsResult.fold((error) => emit(SavingsState.error(error)), (
            assets,
          ) {
            userSavingsResult.fold(
              (error) => emit(SavingsState.error(error)),
              (userSavings) => emit(
                SavingsState.loaded(assets: assets, userSavings: userSavings),
              ),
            );
          });
        },
        fundSavings: (e) async {
          emit(const SavingsState.loading());
          final result = await _repository.fundSavings(
            assetId: e.assetId,
            amount: e.amount,
          );

          result.fold((error) => emit(SavingsState.error(error)), (_) {
            emit(
              const SavingsState.success('Successfully funded savings plan'),
            );
            add(const SavingsEvent.started()); // Refresh data
          });
        },
      );
    });
  }
}
