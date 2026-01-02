import 'dart:io';
import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

abstract class SettingsRepository {
  Future<Either<String, UserEntity>> getUserProfile();
  Future<Either<String, void>> updateUserProfile(UserEntity user);
  Future<Either<String, String>> updateProfilePhoto(
    File image,
  ); // Returns new photo URL
  Future<Either<String, void>> logout();
}
