import 'package:dartz/dartz.dart';
import '../../data/models/payment_response.dart';

abstract class PaymentRepository {
  Future<Either<String, PaymentResponse>> initializePayment({
    required String email,
    required double amount,
    required String reference,
  });

  Future<Either<String, bool>> verifyPayment(String reference);

  // Virtual Account & Address Generation
  Future<Either<String, String>> generateVirtualAccount(String userId);
  Future<Either<String, Map<String, String>>> generateCryptoAddresses(
    String userId,
  );

  // Native Paystack
  Future<Either<String, void>> payWithPaystack({
    required String email,
    required double amount,
    required String reference,
    required Function(String) onSuccess,
  });
}
