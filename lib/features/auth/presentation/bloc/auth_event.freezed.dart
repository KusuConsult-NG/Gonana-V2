// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( SignInRequested value)?  signInRequested,TResult Function( SignUpRequested value)?  signUpRequested,TResult Function( ForgotPasswordRequested value)?  forgotPasswordRequested,TResult Function( BiometricLoginRequested value)?  biometricLoginRequested,TResult Function( GoogleSignInRequested value)?  googleSignInRequested,TResult Function( LogoutRequested value)?  logoutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case SignInRequested() when signInRequested != null:
return signInRequested(_that);case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that);case BiometricLoginRequested() when biometricLoginRequested != null:
return biometricLoginRequested(_that);case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( SignInRequested value)  signInRequested,required TResult Function( SignUpRequested value)  signUpRequested,required TResult Function( ForgotPasswordRequested value)  forgotPasswordRequested,required TResult Function( BiometricLoginRequested value)  biometricLoginRequested,required TResult Function( GoogleSignInRequested value)  googleSignInRequested,required TResult Function( LogoutRequested value)  logoutRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case SignInRequested():
return signInRequested(_that);case SignUpRequested():
return signUpRequested(_that);case ForgotPasswordRequested():
return forgotPasswordRequested(_that);case BiometricLoginRequested():
return biometricLoginRequested(_that);case GoogleSignInRequested():
return googleSignInRequested(_that);case LogoutRequested():
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( SignInRequested value)?  signInRequested,TResult? Function( SignUpRequested value)?  signUpRequested,TResult? Function( ForgotPasswordRequested value)?  forgotPasswordRequested,TResult? Function( BiometricLoginRequested value)?  biometricLoginRequested,TResult? Function( GoogleSignInRequested value)?  googleSignInRequested,TResult? Function( LogoutRequested value)?  logoutRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case SignInRequested() when signInRequested != null:
return signInRequested(_that);case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that);case BiometricLoginRequested() when biometricLoginRequested != null:
return biometricLoginRequested(_that);case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String email,  String password)?  signInRequested,TResult Function( String firstName,  String lastName,  String phoneNumber,  String email,  String password,  String country)?  signUpRequested,TResult Function( String email)?  forgotPasswordRequested,TResult Function()?  biometricLoginRequested,TResult Function()?  googleSignInRequested,TResult Function()?  logoutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.password,_that.country);case ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case BiometricLoginRequested() when biometricLoginRequested != null:
return biometricLoginRequested();case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String email,  String password)  signInRequested,required TResult Function( String firstName,  String lastName,  String phoneNumber,  String email,  String password,  String country)  signUpRequested,required TResult Function( String email)  forgotPasswordRequested,required TResult Function()  biometricLoginRequested,required TResult Function()  googleSignInRequested,required TResult Function()  logoutRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case SignInRequested():
return signInRequested(_that.email,_that.password);case SignUpRequested():
return signUpRequested(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.password,_that.country);case ForgotPasswordRequested():
return forgotPasswordRequested(_that.email);case BiometricLoginRequested():
return biometricLoginRequested();case GoogleSignInRequested():
return googleSignInRequested();case LogoutRequested():
return logoutRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String email,  String password)?  signInRequested,TResult? Function( String firstName,  String lastName,  String phoneNumber,  String email,  String password,  String country)?  signUpRequested,TResult? Function( String email)?  forgotPasswordRequested,TResult? Function()?  biometricLoginRequested,TResult? Function()?  googleSignInRequested,TResult? Function()?  logoutRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.password,_that.country);case ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case BiometricLoginRequested() when biometricLoginRequested != null:
return biometricLoginRequested();case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
  return null;

}
}

}

/// @nodoc


class Started implements AuthEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class SignInRequested implements AuthEvent {
  const SignInRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInRequestedCopyWith<SignInRequested> get copyWith => _$SignInRequestedCopyWithImpl<SignInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signInRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignInRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignInRequestedCopyWith(SignInRequested value, $Res Function(SignInRequested) _then) = _$SignInRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$SignInRequestedCopyWithImpl<$Res>
    implements $SignInRequestedCopyWith<$Res> {
  _$SignInRequestedCopyWithImpl(this._self, this._then);

  final SignInRequested _self;
  final $Res Function(SignInRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SignInRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignUpRequested implements AuthEvent {
  const SignUpRequested({required this.firstName, required this.lastName, required this.phoneNumber, required this.email, required this.password, required this.country});
  

 final  String firstName;
 final  String lastName;
 final  String phoneNumber;
 final  String email;
 final  String password;
 final  String country;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpRequestedCopyWith<SignUpRequested> get copyWith => _$SignUpRequestedCopyWithImpl<SignUpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpRequested&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phoneNumber,email,password,country);

@override
String toString() {
  return 'AuthEvent.signUpRequested(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, password: $password, country: $country)';
}


}

/// @nodoc
abstract mixin class $SignUpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignUpRequestedCopyWith(SignUpRequested value, $Res Function(SignUpRequested) _then) = _$SignUpRequestedCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String phoneNumber, String email, String password, String country
});




}
/// @nodoc
class _$SignUpRequestedCopyWithImpl<$Res>
    implements $SignUpRequestedCopyWith<$Res> {
  _$SignUpRequestedCopyWithImpl(this._self, this._then);

  final SignUpRequested _self;
  final $Res Function(SignUpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? email = null,Object? password = null,Object? country = null,}) {
  return _then(SignUpRequested(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordRequested implements AuthEvent {
  const ForgotPasswordRequested({required this.email});
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordRequestedCopyWith<ForgotPasswordRequested> get copyWith => _$ForgotPasswordRequestedCopyWithImpl<ForgotPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.forgotPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ForgotPasswordRequestedCopyWith(ForgotPasswordRequested value, $Res Function(ForgotPasswordRequested) _then) = _$ForgotPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordRequestedCopyWithImpl<$Res>
    implements $ForgotPasswordRequestedCopyWith<$Res> {
  _$ForgotPasswordRequestedCopyWithImpl(this._self, this._then);

  final ForgotPasswordRequested _self;
  final $Res Function(ForgotPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ForgotPasswordRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BiometricLoginRequested implements AuthEvent {
  const BiometricLoginRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricLoginRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.biometricLoginRequested()';
}


}




/// @nodoc


class GoogleSignInRequested implements AuthEvent {
  const GoogleSignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleSignInRequested()';
}


}




/// @nodoc


class LogoutRequested implements AuthEvent {
  const LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




// dart format on
