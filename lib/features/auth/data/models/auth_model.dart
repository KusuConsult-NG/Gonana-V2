import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';
import '../../../settings/data/models/user_model.dart';

part 'auth_model.g.dart';

class UserModelConverter
    implements JsonConverter<UserModel, Map<String, dynamic>> {
  const UserModelConverter();

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserModel object) => object.toJson();
}

@JsonSerializable()
class AuthModel implements AuthEntity {
  @override
  @UserModelConverter()
  @JsonKey(name: 'user')
  final UserModel user;

  @override
  final String token;

  const AuthModel({required this.user, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      user: UserModel.fromEntity(entity.user),
      token: entity.token,
    );
  }

  @override
  List<Object?> get props => [user, token];

  @override
  bool? get stringify => true;
}
