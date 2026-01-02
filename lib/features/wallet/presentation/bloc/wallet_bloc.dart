import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import 'package:injectable/injectable.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';
part 'wallet_bloc.freezed.dart';

@injectable
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;

  WalletBloc(this._walletRepository) : super(const WalletState.initial()) {
    on<_LoadWalletData>(_onLoadWalletData);
  }

  Future<void> _onLoadWalletData(
    _LoadWalletData event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletState.loading());
    try {
      final wallet = await _walletRepository.getWalletBalance();
      final transactions = await _walletRepository.getTransactions();
      emit(WalletState.loaded(wallet: wallet, transactions: transactions));
    } catch (e) {
      emit(WalletState.error(e.toString()));
    }
  }
}
