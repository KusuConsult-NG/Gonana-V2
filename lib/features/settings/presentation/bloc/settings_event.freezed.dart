// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( LogoutRequested value)?  logoutRequested,TResult Function( UpdateProfile value)?  updateProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( LogoutRequested value)  logoutRequested,required TResult Function( UpdateProfile value)  updateProfile,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case LogoutRequested():
return logoutRequested(_that);case UpdateProfile():
return updateProfile(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( LogoutRequested value)?  logoutRequested,TResult? Function( UpdateProfile value)?  updateProfile,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  logoutRequested,TResult Function( String firstName,  String lastName,  File? profilePhoto,  String? bio)?  updateProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  logoutRequested,required TResult Function( String firstName,  String lastName,  File? profilePhoto,  String? bio)  updateProfile,}) {final _that = this;
switch (_that) {
case Started():
return started();case LogoutRequested():
return logoutRequested();case UpdateProfile():
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  logoutRequested,TResult? Function( String firstName,  String lastName,  File? profilePhoto,  String? bio)?  updateProfile,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio);case _:
  return null;

}
}

}

/// @nodoc


class Started implements SettingsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class LogoutRequested implements SettingsEvent {
  const LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.logoutRequested()';
}


}




/// @nodoc


class UpdateProfile implements SettingsEvent {
  const UpdateProfile({required this.firstName, required this.lastName, this.profilePhoto, this.bio});
  

 final  String firstName;
 final  String lastName;
 final  File? profilePhoto;
 final  String? bio;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileCopyWith<UpdateProfile> get copyWith => _$UpdateProfileCopyWithImpl<UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.profilePhoto, profilePhoto) || other.profilePhoto == profilePhoto)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,profilePhoto,bio);

@override
String toString() {
  return 'SettingsEvent.updateProfile(firstName: $firstName, lastName: $lastName, profilePhoto: $profilePhoto, bio: $bio)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $UpdateProfileCopyWith(UpdateProfile value, $Res Function(UpdateProfile) _then) = _$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, File? profilePhoto, String? bio
});




}
/// @nodoc
class _$UpdateProfileCopyWithImpl<$Res>
    implements $UpdateProfileCopyWith<$Res> {
  _$UpdateProfileCopyWithImpl(this._self, this._then);

  final UpdateProfile _self;
  final $Res Function(UpdateProfile) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? profilePhoto = freezed,Object? bio = freezed,}) {
  return _then(UpdateProfile(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,profilePhoto: freezed == profilePhoto ? _self.profilePhoto : profilePhoto // ignore: cast_nullable_to_non_nullable
as File?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
