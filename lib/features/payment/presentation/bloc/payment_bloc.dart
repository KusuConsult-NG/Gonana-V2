import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../data/paystack_config.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;
  final PaystackPlugin _paystack = PaystackPlugin();
  bool _isPaystackInitialized = false;

  PaymentBloc(this._repository) : super(const PaymentState.initial()) {
    on<_PayWithPaystack>(_onPayWithPaystack);
    on<_GenerateVirtualAccount>(_onGenerateVirtualAccount);
    on<_GenerateCryptoAddresses>(_onGenerateCryptoAddresses);
    _initPaystack();
  }

  void _initPaystack() {
    if (!_isPaystackInitialized) {
      _paystack.initialize(publicKey: PaystackConfig.publicKey);
      _isPaystackInitialized = true;
    }
  }

  Future<void> _onPayWithPaystack(
    _PayWithPaystack event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loading());
    try {
      final charge = Charge()
        ..amount = (event.amount * 100).toInt()
        ..email = event.email
        ..reference = event.reference
        ..currency = 'NGN';

      final response = await _paystack.checkout(
        event.context,
        method: CheckoutMethod.card, // or selectable
        charge: charge,
      );

      if (response.status) {
        // Verify payment on backend (via Repo)
        final verification = await _repository.verifyPayment(
          response.reference!,
        );
        verification.fold(
          (failure) => emit(PaymentState.error(failure)),
          (_) => emit(const PaymentState.success('Payment Successful')),
        );
      } else {
        emit(const PaymentState.error('Payment Cancelled or Failed'));
      }
    } catch (e) {
      emit(PaymentState.error(e.toString()));
    }
  }

  Future<void> _onGenerateVirtualAccount(
    _GenerateVirtualAccount event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loading());
    // In a real app, we get User ID from AuthBloc or User Session
    const userId = "current_user_id";
    final result = await _repository.generateVirtualAccount(userId);
    result.fold(
      (failure) => emit(PaymentState.error(failure)),
      (account) => emit(PaymentState.virtualAccountGenerated(account)),
    );
  }

  Future<void> _onGenerateCryptoAddresses(
    _GenerateCryptoAddresses event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loading());
    const userId = "current_user_id";
    final result = await _repository.generateCryptoAddresses(userId);
    result.fold(
      (failure) => emit(PaymentState.error(failure)),
      (addresses) => emit(PaymentState.cryptoAddressesGenerated(addresses)),
    );
  }
}
