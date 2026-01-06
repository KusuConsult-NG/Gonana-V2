import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Service for securely storing sensitive data like user credentials
/// Used for biometric re-authentication
@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyUserEmail = 'user_email';
  static const String _keyBiometricEnabled = 'biometric_enabled';

  /// Save user email for biometric re-authentication
  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _keyUserEmail, value: email);
  }

  /// Get stored user email
  Future<String?> getUserEmail() async {
    return await _storage.read(key: _keyUserEmail);
  }

  /// Clear user email (call on logout)
  Future<void> clearUserEmail() async {
    await _storage.delete(key: _keyUserEmail);
  }

  /// Check if user has enabled biometrics
  Future<bool> hasBiometricEnabled() async {
    final email = await getUserEmail();
    return email != null && email.isNotEmpty;
  }

  /// Enable biometric authentication
  Future<void> enableBiometric() async {
    await _storage.write(key: _keyBiometricEnabled, value: 'true');
  }

  /// Disable biometric authentication
  Future<void> disableBiometric() async {
    await _storage.delete(key: _keyBiometricEnabled);
    await clearUserEmail();
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
