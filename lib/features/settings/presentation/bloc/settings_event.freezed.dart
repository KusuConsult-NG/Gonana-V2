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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( LogoutRequested value)?  logoutRequested,TResult Function( UpdateProfile value)?  updateProfile,TResult Function( ChangePasswordRequested value)?  changePasswordRequested,TResult Function( ChangePinRequested value)?  changePinRequested,TResult Function( ToggleBiometricsRequested value)?  toggleBiometricsRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case ChangePasswordRequested() when changePasswordRequested != null:
return changePasswordRequested(_that);case ChangePinRequested() when changePinRequested != null:
return changePinRequested(_that);case ToggleBiometricsRequested() when toggleBiometricsRequested != null:
return toggleBiometricsRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( LogoutRequested value)  logoutRequested,required TResult Function( UpdateProfile value)  updateProfile,required TResult Function( ChangePasswordRequested value)  changePasswordRequested,required TResult Function( ChangePinRequested value)  changePinRequested,required TResult Function( ToggleBiometricsRequested value)  toggleBiometricsRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case LogoutRequested():
return logoutRequested(_that);case UpdateProfile():
return updateProfile(_that);case ChangePasswordRequested():
return changePasswordRequested(_that);case ChangePinRequested():
return changePinRequested(_that);case ToggleBiometricsRequested():
return toggleBiometricsRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( LogoutRequested value)?  logoutRequested,TResult? Function( UpdateProfile value)?  updateProfile,TResult? Function( ChangePasswordRequested value)?  changePasswordRequested,TResult? Function( ChangePinRequested value)?  changePinRequested,TResult? Function( ToggleBiometricsRequested value)?  toggleBiometricsRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case ChangePasswordRequested() when changePasswordRequested != null:
return changePasswordRequested(_that);case ChangePinRequested() when changePinRequested != null:
return changePinRequested(_that);case ToggleBiometricsRequested() when toggleBiometricsRequested != null:
return toggleBiometricsRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  logoutRequested,TResult Function( String firstName,  String lastName,  File? profilePhoto,  String? bio,  String? username)?  updateProfile,TResult Function( String oldPassword,  String newPassword)?  changePasswordRequested,TResult Function( String oldPin,  String newPin)?  changePinRequested,TResult Function( bool enabled)?  toggleBiometricsRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio,_that.username);case ChangePasswordRequested() when changePasswordRequested != null:
return changePasswordRequested(_that.oldPassword,_that.newPassword);case ChangePinRequested() when changePinRequested != null:
return changePinRequested(_that.oldPin,_that.newPin);case ToggleBiometricsRequested() when toggleBiometricsRequested != null:
return toggleBiometricsRequested(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  logoutRequested,required TResult Function( String firstName,  String lastName,  File? profilePhoto,  String? bio,  String? username)  updateProfile,required TResult Function( String oldPassword,  String newPassword)  changePasswordRequested,required TResult Function( String oldPin,  String newPin)  changePinRequested,required TResult Function( bool enabled)  toggleBiometricsRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case LogoutRequested():
return logoutRequested();case UpdateProfile():
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio,_that.username);case ChangePasswordRequested():
return changePasswordRequested(_that.oldPassword,_that.newPassword);case ChangePinRequested():
return changePinRequested(_that.oldPin,_that.newPin);case ToggleBiometricsRequested():
return toggleBiometricsRequested(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  logoutRequested,TResult? Function( String firstName,  String lastName,  File? profilePhoto,  String? bio,  String? username)?  updateProfile,TResult? Function( String oldPassword,  String newPassword)?  changePasswordRequested,TResult? Function( String oldPin,  String newPin)?  changePinRequested,TResult? Function( bool enabled)?  toggleBiometricsRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.profilePhoto,_that.bio,_that.username);case ChangePasswordRequested() when changePasswordRequested != null:
return changePasswordRequested(_that.oldPassword,_that.newPassword);case ChangePinRequested() when changePinRequested != null:
return changePinRequested(_that.oldPin,_that.newPin);case ToggleBiometricsRequested() when toggleBiometricsRequested != null:
return toggleBiometricsRequested(_that.enabled);case _:
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
  const UpdateProfile({required this.firstName, required this.lastName, this.profilePhoto, this.bio, this.username});
  

 final  String firstName;
 final  String lastName;
 final  File? profilePhoto;
 final  String? bio;
 final  String? username;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileCopyWith<UpdateProfile> get copyWith => _$UpdateProfileCopyWithImpl<UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.profilePhoto, profilePhoto) || other.profilePhoto == profilePhoto)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,profilePhoto,bio,username);

@override
String toString() {
  return 'SettingsEvent.updateProfile(firstName: $firstName, lastName: $lastName, profilePhoto: $profilePhoto, bio: $bio, username: $username)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $UpdateProfileCopyWith(UpdateProfile value, $Res Function(UpdateProfile) _then) = _$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, File? profilePhoto, String? bio, String? username
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
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? profilePhoto = freezed,Object? bio = freezed,Object? username = freezed,}) {
  return _then(UpdateProfile(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,profilePhoto: freezed == profilePhoto ? _self.profilePhoto : profilePhoto // ignore: cast_nullable_to_non_nullable
as File?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChangePasswordRequested implements SettingsEvent {
  const ChangePasswordRequested({required this.oldPassword, required this.newPassword});
  

 final  String oldPassword;
 final  String newPassword;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestedCopyWith<ChangePasswordRequested> get copyWith => _$ChangePasswordRequestedCopyWithImpl<ChangePasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequested&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,oldPassword,newPassword);

@override
String toString() {
  return 'SettingsEvent.changePasswordRequested(oldPassword: $oldPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ChangePasswordRequestedCopyWith(ChangePasswordRequested value, $Res Function(ChangePasswordRequested) _then) = _$ChangePasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String oldPassword, String newPassword
});




}
/// @nodoc
class _$ChangePasswordRequestedCopyWithImpl<$Res>
    implements $ChangePasswordRequestedCopyWith<$Res> {
  _$ChangePasswordRequestedCopyWithImpl(this._self, this._then);

  final ChangePasswordRequested _self;
  final $Res Function(ChangePasswordRequested) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldPassword = null,Object? newPassword = null,}) {
  return _then(ChangePasswordRequested(
oldPassword: null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangePinRequested implements SettingsEvent {
  const ChangePinRequested({required this.oldPin, required this.newPin});
  

 final  String oldPin;
 final  String newPin;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePinRequestedCopyWith<ChangePinRequested> get copyWith => _$ChangePinRequestedCopyWithImpl<ChangePinRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePinRequested&&(identical(other.oldPin, oldPin) || other.oldPin == oldPin)&&(identical(other.newPin, newPin) || other.newPin == newPin));
}


@override
int get hashCode => Object.hash(runtimeType,oldPin,newPin);

@override
String toString() {
  return 'SettingsEvent.changePinRequested(oldPin: $oldPin, newPin: $newPin)';
}


}

/// @nodoc
abstract mixin class $ChangePinRequestedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ChangePinRequestedCopyWith(ChangePinRequested value, $Res Function(ChangePinRequested) _then) = _$ChangePinRequestedCopyWithImpl;
@useResult
$Res call({
 String oldPin, String newPin
});




}
/// @nodoc
class _$ChangePinRequestedCopyWithImpl<$Res>
    implements $ChangePinRequestedCopyWith<$Res> {
  _$ChangePinRequestedCopyWithImpl(this._self, this._then);

  final ChangePinRequested _self;
  final $Res Function(ChangePinRequested) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldPin = null,Object? newPin = null,}) {
  return _then(ChangePinRequested(
oldPin: null == oldPin ? _self.oldPin : oldPin // ignore: cast_nullable_to_non_nullable
as String,newPin: null == newPin ? _self.newPin : newPin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToggleBiometricsRequested implements SettingsEvent {
  const ToggleBiometricsRequested(this.enabled);
  

 final  bool enabled;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleBiometricsRequestedCopyWith<ToggleBiometricsRequested> get copyWith => _$ToggleBiometricsRequestedCopyWithImpl<ToggleBiometricsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleBiometricsRequested&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SettingsEvent.toggleBiometricsRequested(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $ToggleBiometricsRequestedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ToggleBiometricsRequestedCopyWith(ToggleBiometricsRequested value, $Res Function(ToggleBiometricsRequested) _then) = _$ToggleBiometricsRequestedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$ToggleBiometricsRequestedCopyWithImpl<$Res>
    implements $ToggleBiometricsRequestedCopyWith<$Res> {
  _$ToggleBiometricsRequestedCopyWithImpl(this._self, this._then);

  final ToggleBiometricsRequested _self;
  final $Res Function(ToggleBiometricsRequested) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(ToggleBiometricsRequested(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
