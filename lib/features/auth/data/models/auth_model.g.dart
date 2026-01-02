// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  user: const UserModelConverter().fromJson(
    json['user'] as Map<String, dynamic>,
  ),
  token: json['token'] as String,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'user': const UserModelConverter().toJson(instance.user),
  'token': instance.token,
};
