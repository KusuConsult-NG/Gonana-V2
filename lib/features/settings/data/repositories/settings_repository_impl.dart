import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart'; // For debugPrints
import '../../../settings/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final FirebaseStorage _storage;

  SettingsRepositoryImpl(this._storage);

  // In-Memory Mock User for Demo Persistence
  static UserModel _mockUser = const UserModel(
    id: 'mock_uid_123',
    email: 'john.doe@gonana.farm',
    firstName: 'John',
    lastName: 'Doe',
    profilePhoto: 'https://i.pravatar.cc/300',
    accountType: 'Farmer',
    phone: '+2348012345678',
    emailActivated: true,
    bio: 'Passionate about sustainable agriculture.',
    username: 'john_doe',
    kycStatus: 'verified',
  );

  static const String _userKey = 'gonana_user_profile';

  Future<void> _saveUser(UserModel user) async {
    String? jsonString; // Declare jsonString outside try block for scope
    try {
      final prefs = await SharedPreferences.getInstance();
      jsonString = json.encode(user.toJson());
      await prefs.setString(_userKey, jsonString);
      _mockUser = user;
    } catch (e) {
      debugPrint('Error saving user to prefs: $e. Data attempted: $jsonString');
    }
  }

  Future<UserModel?> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userKey);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return UserModel.fromJson(jsonMap);
      }
    } catch (e) {
      print('Error loading user from prefs: $e');
    }
    return null;
  }

  @override
  Future<bool> getBiometricsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometrics_enabled') ?? false;
  }

  @override
  Future<void> setBiometricsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometrics_enabled', enabled);
  }

  @override
  Future<Either<String, UserEntity>> getUserProfile() async {
    // Return Mock User or Load from Prefs
    await Future.delayed(const Duration(milliseconds: 500));
    final savedUser = await _loadUser();
    if (savedUser != null) {
      _mockUser = savedUser;
      return Right(savedUser);
    }
    return Right(_mockUser);
  }

  @override
  Future<Either<String, void>> updateUserProfile(UserEntity user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Update Mock User
    _mockUser = _mockUser.copyWith(
      firstName: user.firstName,
      lastName: user.lastName,
      profilePhoto:
          user.profilePhoto, // Ensure photo is carried over if not changed
      bio: user.bio,
      username: user.username,
    );
    await _saveUser(_mockUser);
    return const Right(null);
  }

  @override
  Future<Either<String, String>> updateProfilePhoto(File image) async {
    try {
      // Try Real Upload if Storage is available
      final ref = _storage
          .ref()
          .child('user_profiles')
          .child(
            '${_mockUser.id}_${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
      await ref.putFile(image);
      final newPhotoUrl = await ref.getDownloadURL();

      _mockUser = _mockUser.copyWith(profilePhoto: newPhotoUrl);
      await _saveUser(_mockUser);
      return Right(newPhotoUrl);
    } catch (e) {
      // Fallback to Mock if storage fails (e.g. permission or not init)
      debugPrint('Upload failed, falling back to mock: $e');
      final newPhotoUrl =
          'https://i.pravatar.cc/300?u=${DateTime.now().millisecondsSinceEpoch}';
      _mockUser = _mockUser.copyWith(profilePhoto: newPhotoUrl);
      await _saveUser(_mockUser);
      return Right(newPhotoUrl);
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    return const Right(null);
  }

  @override
  Future<Either<String, void>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      // In a real implementation with Firebase:
      // final user = _auth.currentUser;
      // final credential = EmailAuthProvider.credential(email: user.email!, password: oldPassword);
      // await user.reauthenticateWithCredential(credential);
      // await user.updatePassword(newPassword);

      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left('Failed to change password: $e');
    }
  }

  @override
  Future<Either<String, void>> changePin(String oldPin, String newPin) async {
    try {
      // Gate Logic: Must be verified to set/change PIN
      if (_mockUser.kycStatus != 'verified') {
        return const Left('KYC Verification Required');
      }

      // Logic: If oldPin is empty string, we treat it as "Set Initial PIN"
      // If oldPin is provided, we verify it matches current (mock) logic

      // In real backend, we'd verify oldPin. Here we just accept.
      _mockUser = _mockUser.copyWith(pin: newPin);
      await _saveUser(_mockUser);

      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left('Failed to change PIN: $e');
    }
  }

  @override
  Future<Either<String, void>> toggleBiometrics(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('biometrics_enabled', enabled);
      return const Right(null);
    } catch (e) {
      return Left('Failed to toggle biometrics: $e');
    }
  }
}
