// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String?,
  body: json['body'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
  ownerId: json['ownerId'] as String?,
  ownerName: json['ownerName'] as String?,
  ownerPhoto: json['ownerPhoto'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  isLiked: json['isLiked'] as bool? ?? false,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'images': instance.images,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'ownerId': instance.ownerId,
  'ownerName': instance.ownerName,
  'ownerPhoto': instance.ownerPhoto,
  'createdAt': instance.createdAt?.toIso8601String(),
  'isLiked': instance.isLiked,
};
