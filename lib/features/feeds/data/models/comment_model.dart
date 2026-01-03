import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String? userName;
  final String? userPhoto;
  final String text;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    this.userName,
    this.userPhoto,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommentModel.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
    });
  }

  factory CommentModel.fromEntity(CommentEntity entity) => CommentModel(
    id: entity.id,
    postId: entity.postId,
    userId: entity.userId,
    userName: entity.userName,
    userPhoto: entity.userPhoto,
    text: entity.text,
    createdAt: entity.createdAt,
  );

  CommentEntity toEntity() => CommentEntity(
    id: id,
    postId: postId,
    userId: userId,
    userName: userName,
    userPhoto: userPhoto,
    text: text,
    createdAt: createdAt,
  );
}
