import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String? videoUrl;
  final String ownerName;
  final String ownerPhoto;
  final bool isViewed;

  const StoryEntity({
    required this.id,
    required this.imageUrl,
    this.videoUrl,
    required this.ownerName,
    required this.ownerPhoto,
    this.isViewed = false,
  });

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    videoUrl,
    ownerName,
    ownerPhoto,
    isViewed,
  ];
}
