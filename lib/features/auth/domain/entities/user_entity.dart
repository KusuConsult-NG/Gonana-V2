import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? userType; // Buyer, Seller, Both
  final int? age;
  final String? gender;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.phoneNumber,
    this.userType,
    this.age,
    this.gender,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    userType,
    age,
    gender,
  ];
}
