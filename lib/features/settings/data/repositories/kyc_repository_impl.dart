import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/kyc_repository.dart';
import 'dart:math';

import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';

@LazySingleton(as: KycRepository)
class KycRepositoryImpl implements KycRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Dio _dio;

  KycRepositoryImpl(this._firestore, this._auth, this._dio);

  @override
  Future<Either<String, void>> submitKyc({
    required String idType,
    required String idNumber,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return const Left('User not logged in');

    try {
      // 1. IdentityPass (Prembly) API Call
      String endpoint = '';
      Map<String, dynamic> data = {};

      if (idType.toUpperCase() == 'BVN') {
        endpoint = '${AppConfig.identityPassBaseUrl}/verification/nigeria/bvn';
        data = {'number': idNumber};
      } else if (idType.toUpperCase() == 'NIN') {
        endpoint = '${AppConfig.identityPassBaseUrl}/verification/nigeria/nin';
        data = {'number': idNumber};
      } else if (idType.contains('Other Nationals')) {
        // For other nationals, assuming a manual review or a different Prembly endpoint
        // will be added. For now, we simulate a successful submission.
        await Future.delayed(const Duration(seconds: 2));
      } else {
        return const Left('Unsupported ID Type for live verification');
      }

      if (endpoint.isNotEmpty) {
        final response = await _dio.post(
          endpoint,
          data: data,
          options: Options(
            headers: {
              'x-api-key': AppConfig.identityPassApiKey,
              'app-id': AppConfig.identityPassAppId,
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode != 200 || response.data['status'] == false) {
          return Left(
            response.data['message'] ?? 'Identity verification failed',
          );
        }
      }

      // 2. Update User KYC Status on successful verification
      await _firestore.collection('users').doc(user.uid).update({
        'kycStatus': 'verified',
      });

      // 3. Automated Financial Onboarding
      final String virtualAccount = _generateRandomNumber(10);
      final Map<String, String> cryptoAddresses = {
        'Ethereum': '0x${_generateRandomHexString(40)}',
        'Bitcoin': 'bc1${_generateRandomHexString(32)}',
        'Concordium': '3sb${_generateRandomHexString(45)}',
      };

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('wallet')
          .doc('main')
          .set({
            'virtualAccountNumber': virtualAccount,
            'bankName': 'Gonana Multi-Chain Bank',
            'cryptoAddresses': cryptoAddresses,
            'balanceNgn': FieldValue.increment(0),
            'cryptoBalanceCcd': FieldValue.increment(0),
            'cryptoBalanceEth': FieldValue.increment(0),
          }, SetOptions(merge: true));

      return const Right(null);
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Network error during verification';
      return Left(message);
    } catch (e) {
      return Left('Failed to verify KYC: $e');
    }
  }

  String _generateRandomNumber(int length) {
    final random = Random();
    String result = '';
    for (int i = 0; i < length; i++) {
      result += random.nextInt(10).toString();
    }
    return result;
  }

  String _generateRandomHexString(int length) {
    final random = Random();
    const chars = '0123456789abcdef';
    String result = '';
    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }
    return result;
  }
}
