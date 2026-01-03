import 'package:dartz/dartz.dart';

abstract class KycRepository {
  Future<Either<String, void>> submitKyc({
    required String idType,
    required String idNumber,
  });
}
