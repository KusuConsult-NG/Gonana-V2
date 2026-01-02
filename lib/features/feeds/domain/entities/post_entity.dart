import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? body;
  final List<String> images;
  final int likesCount;
  final int commentsCount;
  final String? ownerId;
  final String? ownerName;
  final String? ownerPhoto;
  final DateTime? createdAt;
  final bool isLiked; // To handle UI state

  const PostEntity({
    this.id,
    this.body,
    this.images = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.ownerId,
    this.ownerName,
    this.ownerPhoto,
    this.createdAt,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
    id,
    body,
    images,
    likesCount,
    commentsCount,
    ownerId,
    ownerName,
    ownerPhoto,
    createdAt,
    isLiked,
  ];
}
