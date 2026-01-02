import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../settings/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  // final FirebaseAuth _auth;
  // final FirebaseFirestore _firestore;
  // final FirebaseStorage _storage;

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
  );

  SettingsRepositoryImpl(/*this._auth, this._firestore, this._storage*/);

  @override
  Future<Either<String, UserEntity>> getUserProfile() async {
    // Return Mock User
    await Future.delayed(const Duration(milliseconds: 500));
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
    );
    return const Right(null);
  }

  @override
  Future<Either<String, String>> updateProfilePhoto(File image) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock Upload - return a different random avatar or just success
    // For demo, we can just return a local file path string or a new network URL
    // Since we can't easily serve local files, let's toggle to a differnet avatar URL
    final newPhotoUrl =
        'https://i.pravatar.cc/300?u=${DateTime.now().millisecondsSinceEpoch}';

    // Update the mock user immediately with new photo
    _mockUser = _mockUser.copyWith(profilePhoto: newPhotoUrl);

    return Right(newPhotoUrl);
  }

  @override
  Future<Either<String, void>> logout() async {
    return const Right(null);
  }
}
