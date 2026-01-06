// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent()';
}


}

/// @nodoc
class $PaymentEventCopyWith<$Res>  {
$PaymentEventCopyWith(PaymentEvent _, $Res Function(PaymentEvent) __);
}


/// Adds pattern-matching-related methods to [PaymentEvent].
extension PaymentEventPatterns on PaymentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PayWithPaystack value)?  payWithPaystack,TResult Function( _GenerateVirtualAccount value)?  generateVirtualAccount,TResult Function( _GenerateCryptoAddresses value)?  generateCryptoAddresses,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayWithPaystack() when payWithPaystack != null:
return payWithPaystack(_that);case _GenerateVirtualAccount() when generateVirtualAccount != null:
return generateVirtualAccount(_that);case _GenerateCryptoAddresses() when generateCryptoAddresses != null:
return generateCryptoAddresses(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PayWithPaystack value)  payWithPaystack,required TResult Function( _GenerateVirtualAccount value)  generateVirtualAccount,required TResult Function( _GenerateCryptoAddresses value)  generateCryptoAddresses,}){
final _that = this;
switch (_that) {
case _PayWithPaystack():
return payWithPaystack(_that);case _GenerateVirtualAccount():
return generateVirtualAccount(_that);case _GenerateCryptoAddresses():
return generateCryptoAddresses(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PayWithPaystack value)?  payWithPaystack,TResult? Function( _GenerateVirtualAccount value)?  generateVirtualAccount,TResult? Function( _GenerateCryptoAddresses value)?  generateCryptoAddresses,}){
final _that = this;
switch (_that) {
case _PayWithPaystack() when payWithPaystack != null:
return payWithPaystack(_that);case _GenerateVirtualAccount() when generateVirtualAccount != null:
return generateVirtualAccount(_that);case _GenerateCryptoAddresses() when generateCryptoAddresses != null:
return generateCryptoAddresses(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BuildContext context,  String email,  double amount,  String reference)?  payWithPaystack,TResult Function()?  generateVirtualAccount,TResult Function()?  generateCryptoAddresses,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayWithPaystack() when payWithPaystack != null:
return payWithPaystack(_that.context,_that.email,_that.amount,_that.reference);case _GenerateVirtualAccount() when generateVirtualAccount != null:
return generateVirtualAccount();case _GenerateCryptoAddresses() when generateCryptoAddresses != null:
return generateCryptoAddresses();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BuildContext context,  String email,  double amount,  String reference)  payWithPaystack,required TResult Function()  generateVirtualAccount,required TResult Function()  generateCryptoAddresses,}) {final _that = this;
switch (_that) {
case _PayWithPaystack():
return payWithPaystack(_that.context,_that.email,_that.amount,_that.reference);case _GenerateVirtualAccount():
return generateVirtualAccount();case _GenerateCryptoAddresses():
return generateCryptoAddresses();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BuildContext context,  String email,  double amount,  String reference)?  payWithPaystack,TResult? Function()?  generateVirtualAccount,TResult? Function()?  generateCryptoAddresses,}) {final _that = this;
switch (_that) {
case _PayWithPaystack() when payWithPaystack != null:
return payWithPaystack(_that.context,_that.email,_that.amount,_that.reference);case _GenerateVirtualAccount() when generateVirtualAccount != null:
return generateVirtualAccount();case _GenerateCryptoAddresses() when generateCryptoAddresses != null:
return generateCryptoAddresses();case _:
  return null;

}
}

}

/// @nodoc


class _PayWithPaystack implements PaymentEvent {
  const _PayWithPaystack({required this.context, required this.email, required this.amount, required this.reference});
  

 final  BuildContext context;
 final  String email;
 final  double amount;
 final  String reference;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayWithPaystackCopyWith<_PayWithPaystack> get copyWith => __$PayWithPaystackCopyWithImpl<_PayWithPaystack>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayWithPaystack&&(identical(other.context, context) || other.context == context)&&(identical(other.email, email) || other.email == email)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference));
}


@override
int get hashCode => Object.hash(runtimeType,context,email,amount,reference);

@override
String toString() {
  return 'PaymentEvent.payWithPaystack(context: $context, email: $email, amount: $amount, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$PayWithPaystackCopyWith<$Res> implements $PaymentEventCopyWith<$Res> {
  factory _$PayWithPaystackCopyWith(_PayWithPaystack value, $Res Function(_PayWithPaystack) _then) = __$PayWithPaystackCopyWithImpl;
@useResult
$Res call({
 BuildContext context, String email, double amount, String reference
});




}
/// @nodoc
class __$PayWithPaystackCopyWithImpl<$Res>
    implements _$PayWithPaystackCopyWith<$Res> {
  __$PayWithPaystackCopyWithImpl(this._self, this._then);

  final _PayWithPaystack _self;
  final $Res Function(_PayWithPaystack) _then;

/// Create a copy of PaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? context = null,Object? email = null,Object? amount = null,Object? reference = null,}) {
  return _then(_PayWithPaystack(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as BuildContext,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GenerateVirtualAccount implements PaymentEvent {
  const _GenerateVirtualAccount();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateVirtualAccount);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.generateVirtualAccount()';
}


}




/// @nodoc


class _GenerateCryptoAddresses implements PaymentEvent {
  const _GenerateCryptoAddresses();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateCryptoAddresses);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentEvent.generateCryptoAddresses()';
}


}




/// @nodoc
mixin _$PaymentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState()';
}


}

/// @nodoc
class $PaymentStateCopyWith<$Res>  {
$PaymentStateCopyWith(PaymentState _, $Res Function(PaymentState) __);
}


/// Adds pattern-matching-related methods to [PaymentState].
extension PaymentStatePatterns on PaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,TResult Function( _VirtualAccountGenerated value)?  virtualAccountGenerated,TResult Function( _CryptoAddressesGenerated value)?  cryptoAddressesGenerated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _VirtualAccountGenerated() when virtualAccountGenerated != null:
return virtualAccountGenerated(_that);case _CryptoAddressesGenerated() when cryptoAddressesGenerated != null:
return cryptoAddressesGenerated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,required TResult Function( _VirtualAccountGenerated value)  virtualAccountGenerated,required TResult Function( _CryptoAddressesGenerated value)  cryptoAddressesGenerated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _VirtualAccountGenerated():
return virtualAccountGenerated(_that);case _CryptoAddressesGenerated():
return cryptoAddressesGenerated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,TResult? Function( _VirtualAccountGenerated value)?  virtualAccountGenerated,TResult? Function( _CryptoAddressesGenerated value)?  cryptoAddressesGenerated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _VirtualAccountGenerated() when virtualAccountGenerated != null:
return virtualAccountGenerated(_that);case _CryptoAddressesGenerated() when cryptoAddressesGenerated != null:
return cryptoAddressesGenerated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  success,TResult Function( String message)?  error,TResult Function( String accountNumber)?  virtualAccountGenerated,TResult Function( Map<String, String> addresses)?  cryptoAddressesGenerated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _VirtualAccountGenerated() when virtualAccountGenerated != null:
return virtualAccountGenerated(_that.accountNumber);case _CryptoAddressesGenerated() when cryptoAddressesGenerated != null:
return cryptoAddressesGenerated(_that.addresses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  success,required TResult Function( String message)  error,required TResult Function( String accountNumber)  virtualAccountGenerated,required TResult Function( Map<String, String> addresses)  cryptoAddressesGenerated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.message);case _Error():
return error(_that.message);case _VirtualAccountGenerated():
return virtualAccountGenerated(_that.accountNumber);case _CryptoAddressesGenerated():
return cryptoAddressesGenerated(_that.addresses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  success,TResult? Function( String message)?  error,TResult? Function( String accountNumber)?  virtualAccountGenerated,TResult? Function( Map<String, String> addresses)?  cryptoAddressesGenerated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _VirtualAccountGenerated() when virtualAccountGenerated != null:
return virtualAccountGenerated(_that.accountNumber);case _CryptoAddressesGenerated() when cryptoAddressesGenerated != null:
return cryptoAddressesGenerated(_that.addresses);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PaymentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.initial()';
}


}




/// @nodoc


class _Loading implements PaymentState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.loading()';
}


}




/// @nodoc


class _Success implements PaymentState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PaymentState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements PaymentState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PaymentState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VirtualAccountGenerated implements PaymentState {
  const _VirtualAccountGenerated(this.accountNumber);
  

 final  String accountNumber;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VirtualAccountGeneratedCopyWith<_VirtualAccountGenerated> get copyWith => __$VirtualAccountGeneratedCopyWithImpl<_VirtualAccountGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VirtualAccountGenerated&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber));
}


@override
int get hashCode => Object.hash(runtimeType,accountNumber);

@override
String toString() {
  return 'PaymentState.virtualAccountGenerated(accountNumber: $accountNumber)';
}


}

/// @nodoc
abstract mixin class _$VirtualAccountGeneratedCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$VirtualAccountGeneratedCopyWith(_VirtualAccountGenerated value, $Res Function(_VirtualAccountGenerated) _then) = __$VirtualAccountGeneratedCopyWithImpl;
@useResult
$Res call({
 String accountNumber
});




}
/// @nodoc
class __$VirtualAccountGeneratedCopyWithImpl<$Res>
    implements _$VirtualAccountGeneratedCopyWith<$Res> {
  __$VirtualAccountGeneratedCopyWithImpl(this._self, this._then);

  final _VirtualAccountGenerated _self;
  final $Res Function(_VirtualAccountGenerated) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accountNumber = null,}) {
  return _then(_VirtualAccountGenerated(
null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CryptoAddressesGenerated implements PaymentState {
  const _CryptoAddressesGenerated(final  Map<String, String> addresses): _addresses = addresses;
  

 final  Map<String, String> _addresses;
 Map<String, String> get addresses {
  if (_addresses is EqualUnmodifiableMapView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_addresses);
}


/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CryptoAddressesGeneratedCopyWith<_CryptoAddressesGenerated> get copyWith => __$CryptoAddressesGeneratedCopyWithImpl<_CryptoAddressesGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CryptoAddressesGenerated&&const DeepCollectionEquality().equals(other._addresses, _addresses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses));

@override
String toString() {
  return 'PaymentState.cryptoAddressesGenerated(addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class _$CryptoAddressesGeneratedCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$CryptoAddressesGeneratedCopyWith(_CryptoAddressesGenerated value, $Res Function(_CryptoAddressesGenerated) _then) = __$CryptoAddressesGeneratedCopyWithImpl;
@useResult
$Res call({
 Map<String, String> addresses
});




}
/// @nodoc
class __$CryptoAddressesGeneratedCopyWithImpl<$Res>
    implements _$CryptoAddressesGeneratedCopyWith<$Res> {
  __$CryptoAddressesGeneratedCopyWithImpl(this._self, this._then);

  final _CryptoAddressesGenerated _self;
  final $Res Function(_CryptoAddressesGenerated) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,}) {
  return _then(_CryptoAddressesGenerated(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
