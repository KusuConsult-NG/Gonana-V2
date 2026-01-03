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
  final List<String> likedBy; // List of user IDs who liked the post

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
    this.likedBy = const [],
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
    likedBy,
  ];

  PostEntity copyWith({
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
    return PostEntity(
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
}
