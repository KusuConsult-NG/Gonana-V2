import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? bio;
  final String? phone;
  final String? accountType;
  final bool? emailActivated;

  const UserEntity({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.coverPhoto,
    this.bio,
    this.phone,
    this.accountType,
    this.emailActivated,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    profilePhoto,
    coverPhoto,
    bio,
    phone,
    accountType,
    emailActivated,
  ];
  UserEntity copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profilePhoto,
    String? coverPhoto,
    String? bio,
    String? phone,
    String? accountType,
    bool? emailActivated,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      accountType: accountType ?? this.accountType,
      emailActivated: emailActivated ?? this.emailActivated,
    );
  }
}
