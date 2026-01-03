import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.email,
    super.firstName,
    super.lastName,
    super.profilePhoto,
    super.coverPhoto,
    super.bio,
    super.phone,
    super.accountType,
    super.emailActivated,
    super.kycStatus,
    super.username,
    super.pin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      profilePhoto: entity.profilePhoto,
      coverPhoto: entity.coverPhoto,
      bio: entity.bio,
      phone: entity.phone,
      accountType: entity.accountType,
      emailActivated: entity.emailActivated,
      kycStatus: entity.kycStatus,
      username: entity.username,
      pin: entity.pin,
    );
  }
  @override
  UserModel copyWith({
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
    String? kycStatus,
    String? username,
    String? pin,
  }) {
    return UserModel(
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
      kycStatus: kycStatus ?? this.kycStatus,
      username: username ?? this.username,
      pin: pin ?? this.pin,
    );
  }
}
