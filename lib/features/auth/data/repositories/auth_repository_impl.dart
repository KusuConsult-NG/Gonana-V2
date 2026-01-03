import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import '../../../settings/data/models/user_model.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Either<String, AuthEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        return const Left('User data not found');
      }

      final userModel = UserModel.fromJson(userDoc.data()!);
      final token = await credential.user!.getIdToken();

      return Right(AuthEntity(user: userModel, token: token ?? ''));
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Sign in failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthEntity>> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String country,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final userModel = UserModel(
        id: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        profilePhoto: null,
        accountType: 'User',
        phone: phoneNumber,
        emailActivated: false,
      );

      await _firestore.collection('users').doc(uid).set(userModel.toJson());
      final token = await credential.user!.getIdToken();

      return Right(AuthEntity(user: userModel, token: token ?? ''));
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Sign up failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> authenticateBiometric() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) {
        return const Left('Device does not support biometrics');
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to sign in',
        biometricOnly: true,
      );

      if (didAuthenticate) {
        return const Right(true);
      } else {
        return const Left('Authentication failed');
      }
    } catch (e) {
      return Left('Biometric authentication error: $e');
    }
  }

  @override
  Future<Either<String, void>> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Failed to send reset email');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthEntity>> getCurrentAuthentication() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Left('No user logged in');
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        return const Left('User data not found');
      }

      final userModel = UserModel.fromJson(userDoc.data()!);
      final token = await user.getIdToken();

      return Right(AuthEntity(user: userModel, token: token ?? ''));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
