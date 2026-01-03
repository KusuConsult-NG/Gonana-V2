import 'package:dartz/dartz.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<String, AuthEntity>> signIn({
    required String email,
    required String password,
  });
  Future<Either<String, AuthEntity>> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String country,
  });
  Future<Either<String, void>> forgotPassword({required String email});
  Future<Either<String, void>> signOut();
  Future<Either<String, AuthEntity>> getCurrentAuthentication();
  Future<Either<String, bool>> authenticateBiometric();
}
