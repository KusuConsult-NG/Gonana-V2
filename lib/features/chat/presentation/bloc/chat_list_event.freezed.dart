// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatListEvent()';
}


}

/// @nodoc
class $ChatListEventCopyWith<$Res>  {
$ChatListEventCopyWith(ChatListEvent _, $Res Function(ChatListEvent) __);
}


/// Adds pattern-matching-related methods to [ChatListEvent].
extension ChatListEventPatterns on ChatListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _ChatsUpdated value)?  chatsUpdated,TResult Function( _CreateChat value)?  createChat,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ChatsUpdated() when chatsUpdated != null:
return chatsUpdated(_that);case _CreateChat() when createChat != null:
return createChat(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _ChatsUpdated value)  chatsUpdated,required TResult Function( _CreateChat value)  createChat,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _ChatsUpdated():
return chatsUpdated(_that);case _CreateChat():
return createChat(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _ChatsUpdated value)?  chatsUpdated,TResult? Function( _CreateChat value)?  createChat,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ChatsUpdated() when chatsUpdated != null:
return chatsUpdated(_that);case _CreateChat() when createChat != null:
return createChat(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( List<ChatEntity> chats)?  chatsUpdated,TResult Function( String otherUserId)?  createChat,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ChatsUpdated() when chatsUpdated != null:
return chatsUpdated(_that.chats);case _CreateChat() when createChat != null:
return createChat(_that.otherUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( List<ChatEntity> chats)  chatsUpdated,required TResult Function( String otherUserId)  createChat,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _ChatsUpdated():
return chatsUpdated(_that.chats);case _CreateChat():
return createChat(_that.otherUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( List<ChatEntity> chats)?  chatsUpdated,TResult? Function( String otherUserId)?  createChat,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ChatsUpdated() when chatsUpdated != null:
return chatsUpdated(_that.chats);case _CreateChat() when createChat != null:
return createChat(_that.otherUserId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ChatListEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatListEvent.started()';
}


}




/// @nodoc


class _ChatsUpdated implements ChatListEvent {
  const _ChatsUpdated(final  List<ChatEntity> chats): _chats = chats;
  

 final  List<ChatEntity> _chats;
 List<ChatEntity> get chats {
  if (_chats is EqualUnmodifiableListView) return _chats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chats);
}


/// Create a copy of ChatListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsUpdatedCopyWith<_ChatsUpdated> get copyWith => __$ChatsUpdatedCopyWithImpl<_ChatsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsUpdated&&const DeepCollectionEquality().equals(other._chats, _chats));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chats));

@override
String toString() {
  return 'ChatListEvent.chatsUpdated(chats: $chats)';
}


}

/// @nodoc
abstract mixin class _$ChatsUpdatedCopyWith<$Res> implements $ChatListEventCopyWith<$Res> {
  factory _$ChatsUpdatedCopyWith(_ChatsUpdated value, $Res Function(_ChatsUpdated) _then) = __$ChatsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ChatEntity> chats
});




}
/// @nodoc
class __$ChatsUpdatedCopyWithImpl<$Res>
    implements _$ChatsUpdatedCopyWith<$Res> {
  __$ChatsUpdatedCopyWithImpl(this._self, this._then);

  final _ChatsUpdated _self;
  final $Res Function(_ChatsUpdated) _then;

/// Create a copy of ChatListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? chats = null,}) {
  return _then(_ChatsUpdated(
null == chats ? _self._chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatEntity>,
  ));
}


}

/// @nodoc


class _CreateChat implements ChatListEvent {
  const _CreateChat(this.otherUserId);
  

 final  String otherUserId;

/// Create a copy of ChatListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateChatCopyWith<_CreateChat> get copyWith => __$CreateChatCopyWithImpl<_CreateChat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateChat&&(identical(other.otherUserId, otherUserId) || other.otherUserId == otherUserId));
}


@override
int get hashCode => Object.hash(runtimeType,otherUserId);

@override
String toString() {
  return 'ChatListEvent.createChat(otherUserId: $otherUserId)';
}


}

/// @nodoc
abstract mixin class _$CreateChatCopyWith<$Res> implements $ChatListEventCopyWith<$Res> {
  factory _$CreateChatCopyWith(_CreateChat value, $Res Function(_CreateChat) _then) = __$CreateChatCopyWithImpl;
@useResult
$Res call({
 String otherUserId
});




}
/// @nodoc
class __$CreateChatCopyWithImpl<$Res>
    implements _$CreateChatCopyWith<$Res> {
  __$CreateChatCopyWithImpl(this._self, this._then);

  final _CreateChat _self;
  final $Res Function(_CreateChat) _then;

/// Create a copy of ChatListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otherUserId = null,}) {
  return _then(_CreateChat(
null == otherUserId ? _self.otherUserId : otherUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
