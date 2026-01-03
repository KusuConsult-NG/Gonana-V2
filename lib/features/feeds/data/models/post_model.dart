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
    super.likedBy,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    DateTime? createdAt;
    if (json['createdAt'] is Timestamp) {
      createdAt = (json['createdAt'] as Timestamp).toDate();
    } else if (json['createdAt'] is String) {
      createdAt = DateTime.parse(json['createdAt'] as String);
    }

    return PostModel(
      id: json['id'] as String?,
      body: json['body'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      ownerId: json['ownerId'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerPhoto: json['ownerPhoto'] as String?,
      createdAt: createdAt,
      isLiked: json['isLiked'] as bool? ?? false,
      likedBy:
          (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  // Explicitly reference the generated function to satisfy linter
  // ignore: unused_element
  static void _ensureGeneratedCodeUsed() {
    _$PostModelFromJson;
  }

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  PostModel copyWith({
    String? id,
    String? body,
    List<String>? images,
    int? likesCount,
    int? commentsCount,
    String? ownerId,
    String? ownerName,
    String? ownerPhoto,
    DateTime? createdAt,
    bool? isLiked,
    List<String>? likedBy,
  }) {
    return PostModel(
      id: id ?? this.id,
      body: body ?? this.body,
      images: images ?? this.images,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      ownerPhoto: ownerPhoto ?? this.ownerPhoto,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      likedBy: likedBy ?? this.likedBy,
    );
  }

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
      likedBy: entity.likedBy,
    );
  }
}
