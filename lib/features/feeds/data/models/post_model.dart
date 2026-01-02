import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  const PostModel({
    super.id,
    super.body,
    super.images,
    super.likesCount,
    super.commentsCount,
    super.ownerId,
    super.ownerName,
    super.ownerPhoto,
    super.createdAt,
    super.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      body: entity.body,
      images: entity.images,
      likesCount: entity.likesCount,
      commentsCount: entity.commentsCount,
      ownerId: entity.ownerId,
      ownerName: entity.ownerName,
      ownerPhoto: entity.ownerPhoto,
      createdAt: entity.createdAt,
      isLiked: entity.isLiked,
    );
  }
}
