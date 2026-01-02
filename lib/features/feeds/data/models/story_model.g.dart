// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
  videoUrl: json['videoUrl'] as String?,
  ownerName: json['ownerName'] as String,
  ownerPhoto: json['ownerPhoto'] as String,
  isViewed: json['isViewed'] as bool? ?? false,
);

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'ownerName': instance.ownerName,
      'ownerPhoto': instance.ownerPhoto,
      'isViewed': instance.isViewed,
    };
