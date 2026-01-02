import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/story_entity.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.imageUrl,
    super.videoUrl,
    required super.ownerName,
    required super.ownerPhoto,
    super.isViewed,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  factory StoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StoryModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  factory StoryModel.fromEntity(StoryEntity entity) {
    return StoryModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      videoUrl: entity.videoUrl,
      ownerName: entity.ownerName,
      ownerPhoto: entity.ownerPhoto,
      isViewed: entity.isViewed,
    );
  }
}
