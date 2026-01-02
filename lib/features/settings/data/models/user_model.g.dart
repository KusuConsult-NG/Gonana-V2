// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String?,
  email: json['email'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  profilePhoto: json['profilePhoto'] as String?,
  coverPhoto: json['coverPhoto'] as String?,
  bio: json['bio'] as String?,
  phone: json['phone'] as String?,
  accountType: json['accountType'] as String?,
  emailActivated: json['emailActivated'] as bool?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profilePhoto': instance.profilePhoto,
  'coverPhoto': instance.coverPhoto,
  'bio': instance.bio,
  'phone': instance.phone,
  'accountType': instance.accountType,
  'emailActivated': instance.emailActivated,
};
