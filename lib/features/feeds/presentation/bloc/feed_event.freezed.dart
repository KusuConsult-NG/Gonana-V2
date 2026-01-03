// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent()';
}


}

/// @nodoc
class $FeedEventCopyWith<$Res>  {
$FeedEventCopyWith(FeedEvent _, $Res Function(FeedEvent) __);
}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Refreshed value)?  refreshed,TResult Function( PostLiked value)?  postLiked,TResult Function( PostCommented value)?  postCommented,TResult Function( CreatePost value)?  createPost,TResult Function( PostDeleted value)?  postDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refreshed() when refreshed != null:
return refreshed(_that);case PostLiked() when postLiked != null:
return postLiked(_that);case PostCommented() when postCommented != null:
return postCommented(_that);case CreatePost() when createPost != null:
return createPost(_that);case PostDeleted() when postDeleted != null:
return postDeleted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Refreshed value)  refreshed,required TResult Function( PostLiked value)  postLiked,required TResult Function( PostCommented value)  postCommented,required TResult Function( CreatePost value)  createPost,required TResult Function( PostDeleted value)  postDeleted,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Refreshed():
return refreshed(_that);case PostLiked():
return postLiked(_that);case PostCommented():
return postCommented(_that);case CreatePost():
return createPost(_that);case PostDeleted():
return postDeleted(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Refreshed value)?  refreshed,TResult? Function( PostLiked value)?  postLiked,TResult? Function( PostCommented value)?  postCommented,TResult? Function( CreatePost value)?  createPost,TResult? Function( PostDeleted value)?  postDeleted,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refreshed() when refreshed != null:
return refreshed(_that);case PostLiked() when postLiked != null:
return postLiked(_that);case PostCommented() when postCommented != null:
return postCommented(_that);case CreatePost() when createPost != null:
return createPost(_that);case PostDeleted() when postDeleted != null:
return postDeleted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( String postId,  String userId)?  postLiked,TResult Function( String postId,  String comment,  String userId)?  postCommented,TResult Function( String caption,  File? image)?  createPost,TResult Function( String postId)?  postDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refreshed() when refreshed != null:
return refreshed();case PostLiked() when postLiked != null:
return postLiked(_that.postId,_that.userId);case PostCommented() when postCommented != null:
return postCommented(_that.postId,_that.comment,_that.userId);case CreatePost() when createPost != null:
return createPost(_that.caption,_that.image);case PostDeleted() when postDeleted != null:
return postDeleted(_that.postId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( String postId,  String userId)  postLiked,required TResult Function( String postId,  String comment,  String userId)  postCommented,required TResult Function( String caption,  File? image)  createPost,required TResult Function( String postId)  postDeleted,}) {final _that = this;
switch (_that) {
case Started():
return started();case Refreshed():
return refreshed();case PostLiked():
return postLiked(_that.postId,_that.userId);case PostCommented():
return postCommented(_that.postId,_that.comment,_that.userId);case CreatePost():
return createPost(_that.caption,_that.image);case PostDeleted():
return postDeleted(_that.postId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( String postId,  String userId)?  postLiked,TResult? Function( String postId,  String comment,  String userId)?  postCommented,TResult? Function( String caption,  File? image)?  createPost,TResult? Function( String postId)?  postDeleted,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refreshed() when refreshed != null:
return refreshed();case PostLiked() when postLiked != null:
return postLiked(_that.postId,_that.userId);case PostCommented() when postCommented != null:
return postCommented(_that.postId,_that.comment,_that.userId);case CreatePost() when createPost != null:
return createPost(_that.caption,_that.image);case PostDeleted() when postDeleted != null:
return postDeleted(_that.postId);case _:
  return null;

}
}

}

/// @nodoc


class Started implements FeedEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent.started()';
}


}




/// @nodoc


class Refreshed implements FeedEvent {
  const Refreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent.refreshed()';
}


}




/// @nodoc


class PostLiked implements FeedEvent {
  const PostLiked(this.postId, this.userId);
  

 final  String postId;
 final  String userId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLikedCopyWith<PostLiked> get copyWith => _$PostLikedCopyWithImpl<PostLiked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLiked&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,postId,userId);

@override
String toString() {
  return 'FeedEvent.postLiked(postId: $postId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $PostLikedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $PostLikedCopyWith(PostLiked value, $Res Function(PostLiked) _then) = _$PostLikedCopyWithImpl;
@useResult
$Res call({
 String postId, String userId
});




}
/// @nodoc
class _$PostLikedCopyWithImpl<$Res>
    implements $PostLikedCopyWith<$Res> {
  _$PostLikedCopyWithImpl(this._self, this._then);

  final PostLiked _self;
  final $Res Function(PostLiked) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? userId = null,}) {
  return _then(PostLiked(
null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PostCommented implements FeedEvent {
  const PostCommented(this.postId, this.comment, this.userId);
  

 final  String postId;
 final  String comment;
 final  String userId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCommentedCopyWith<PostCommented> get copyWith => _$PostCommentedCopyWithImpl<PostCommented>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCommented&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,postId,comment,userId);

@override
String toString() {
  return 'FeedEvent.postCommented(postId: $postId, comment: $comment, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $PostCommentedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $PostCommentedCopyWith(PostCommented value, $Res Function(PostCommented) _then) = _$PostCommentedCopyWithImpl;
@useResult
$Res call({
 String postId, String comment, String userId
});




}
/// @nodoc
class _$PostCommentedCopyWithImpl<$Res>
    implements $PostCommentedCopyWith<$Res> {
  _$PostCommentedCopyWithImpl(this._self, this._then);

  final PostCommented _self;
  final $Res Function(PostCommented) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? comment = null,Object? userId = null,}) {
  return _then(PostCommented(
null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreatePost implements FeedEvent {
  const CreatePost({required this.caption, required this.image});
  

 final  String caption;
 final  File? image;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostCopyWith<CreatePost> get copyWith => _$CreatePostCopyWithImpl<CreatePost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePost&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,caption,image);

@override
String toString() {
  return 'FeedEvent.createPost(caption: $caption, image: $image)';
}


}

/// @nodoc
abstract mixin class $CreatePostCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $CreatePostCopyWith(CreatePost value, $Res Function(CreatePost) _then) = _$CreatePostCopyWithImpl;
@useResult
$Res call({
 String caption, File? image
});




}
/// @nodoc
class _$CreatePostCopyWithImpl<$Res>
    implements $CreatePostCopyWith<$Res> {
  _$CreatePostCopyWithImpl(this._self, this._then);

  final CreatePost _self;
  final $Res Function(CreatePost) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? caption = null,Object? image = freezed,}) {
  return _then(CreatePost(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class PostDeleted implements FeedEvent {
  const PostDeleted(this.postId);
  

 final  String postId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDeletedCopyWith<PostDeleted> get copyWith => _$PostDeletedCopyWithImpl<PostDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDeleted&&(identical(other.postId, postId) || other.postId == postId));
}


@override
int get hashCode => Object.hash(runtimeType,postId);

@override
String toString() {
  return 'FeedEvent.postDeleted(postId: $postId)';
}


}

/// @nodoc
abstract mixin class $PostDeletedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $PostDeletedCopyWith(PostDeleted value, $Res Function(PostDeleted) _then) = _$PostDeletedCopyWithImpl;
@useResult
$Res call({
 String postId
});




}
/// @nodoc
class _$PostDeletedCopyWithImpl<$Res>
    implements $PostDeletedCopyWith<$Res> {
  _$PostDeletedCopyWithImpl(this._self, this._then);

  final PostDeleted _self;
  final $Res Function(PostDeleted) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,}) {
  return _then(PostDeleted(
null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
