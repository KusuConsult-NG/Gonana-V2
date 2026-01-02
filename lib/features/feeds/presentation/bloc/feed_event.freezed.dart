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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Refreshed value)?  refreshed,TResult Function( PostLiked value)?  postLiked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refreshed() when refreshed != null:
return refreshed(_that);case PostLiked() when postLiked != null:
return postLiked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Refreshed value)  refreshed,required TResult Function( PostLiked value)  postLiked,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Refreshed():
return refreshed(_that);case PostLiked():
return postLiked(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Refreshed value)?  refreshed,TResult? Function( PostLiked value)?  postLiked,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refreshed() when refreshed != null:
return refreshed(_that);case PostLiked() when postLiked != null:
return postLiked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( String postId)?  postLiked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refreshed() when refreshed != null:
return refreshed();case PostLiked() when postLiked != null:
return postLiked(_that.postId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( String postId)  postLiked,}) {final _that = this;
switch (_that) {
case Started():
return started();case Refreshed():
return refreshed();case PostLiked():
return postLiked(_that.postId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( String postId)?  postLiked,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refreshed() when refreshed != null:
return refreshed();case PostLiked() when postLiked != null:
return postLiked(_that.postId);case _:
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
  const PostLiked(this.postId);
  

 final  String postId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLikedCopyWith<PostLiked> get copyWith => _$PostLikedCopyWithImpl<PostLiked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLiked&&(identical(other.postId, postId) || other.postId == postId));
}


@override
int get hashCode => Object.hash(runtimeType,postId);

@override
String toString() {
  return 'FeedEvent.postLiked(postId: $postId)';
}


}

/// @nodoc
abstract mixin class $PostLikedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $PostLikedCopyWith(PostLiked value, $Res Function(PostLiked) _then) = _$PostLikedCopyWithImpl;
@useResult
$Res call({
 String postId
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
@pragma('vm:prefer-inline') $Res call({Object? postId = null,}) {
  return _then(PostLiked(
null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
