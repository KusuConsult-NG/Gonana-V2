import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaymentCancelledException implements Exception {
  final String message;
  PaymentCancelledException(this.message);
  @override
  String toString() => message;
}

class PaymentFailedException implements Exception {
  final String message;
  PaymentFailedException(this.message);
  @override
  String toString() => message;
}

class PaymentService {
  final Dio _dio = Dio();

  // NOTE: In production, these keys should be in environment variables or secure storage
  static const String publicKey =
      'pk_test_3e87802dae281fbeb004f2b0f741a6e662aba103';
  // Dummy key for testing as requested by user
  static const String secretKey = 'sk_test_dummy_key_for_testing_purposes_123';
  static const String baseUrl = 'https://api.paystack.co';

  void initialize() {
    // Initialize Dio with base configuration
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/json',
    };
  }

  /// Initialize a Paystack transaction and get the authorization URL
  /// This URL will be opened in a webview for the user to complete payment
  Future<String> initializeTransaction({
    required String email,
    required double amount,
    required String reference,
  }) async {
    try {
      // Convert amount to kobo (Paystack expects amount in smallest currency unit)
      final int amountInKobo = (amount * 100).toInt();

      final response = await _dio.post(
        '/transaction/initialize',
        data: {
          'email': email,
          'amount': amountInKobo,
          'reference': reference,
          'currency': 'NGN',
          'callback_url':
              'https://gonana.app/payment/callback', // Replace with your actual callback URL
        },
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final authorizationUrl = response.data['data']['authorization_url'];
        return authorizationUrl;
      } else {
        throw PaymentFailedException('Failed to initialize transaction');
      }
    } on DioException catch (e) {
      throw PaymentFailedException(
        'Network error: ${e.response?.data?['message'] ?? e.message}',
      );
    } catch (e) {
      throw PaymentFailedException('An unexpected error occurred: $e');
    }
  }

  /// Verify a Paystack transaction using the reference
  Future<bool> verifyTransaction(String reference) async {
    try {
      final response = await _dio.get('/transaction/verify/$reference');

      if (response.statusCode == 200 && response.data['status'] == true) {
        final status = response.data['data']['status'];
        return status == 'success';
      }
      return false;
    } on DioException catch (e) {
      debugPrint('Verification Error: ${e.response?.data ?? e.message}');
      return false;
    } catch (e) {
      debugPrint('Verification Error: $e');
      return false;
    }
  }

  /// For mobile app payment flow:
  /// 1. Call initializeTransaction() to get authorization URL
  /// 2. Open URL in webview or browser
  /// 3. User completes payment
  /// 4. You get callback with reference
  /// 5. Call verifyTransaction() to confirm payment
  Future<String> chargeCard({
    required BuildContext context,
    required double amount,
    required String email,
    required String reference,
  }) async {
    // This method will be implemented to open webview with Paystack payment page
    // For now, returning the reference for the flow
    final authUrl = await initializeTransaction(
      email: email,
      amount: amount,
      reference: reference,
    );

    // The authorization URL should be opened in a webview
    // User completes payment there
    // Then we verify using the reference

    return reference;
  }
}
