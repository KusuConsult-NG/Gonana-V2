part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.payWithPaystack({
    required BuildContext context,
    required String email,
    required double amount,
    required String reference,
  }) = _PayWithPaystack;

  const factory PaymentEvent.generateVirtualAccount() = _GenerateVirtualAccount;
  const factory PaymentEvent.generateCryptoAddresses() =
      _GenerateCryptoAddresses;
}
