// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SavingsEvent()';
}


}

/// @nodoc
class $SavingsEventCopyWith<$Res>  {
$SavingsEventCopyWith(SavingsEvent _, $Res Function(SavingsEvent) __);
}


/// Adds pattern-matching-related methods to [SavingsEvent].
extension SavingsEventPatterns on SavingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FundSavings value)?  fundSavings,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FundSavings() when fundSavings != null:
return fundSavings(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FundSavings value)  fundSavings,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FundSavings():
return fundSavings(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FundSavings value)?  fundSavings,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FundSavings() when fundSavings != null:
return fundSavings(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String assetId,  double amount)?  fundSavings,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FundSavings() when fundSavings != null:
return fundSavings(_that.assetId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String assetId,  double amount)  fundSavings,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FundSavings():
return fundSavings(_that.assetId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String assetId,  double amount)?  fundSavings,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FundSavings() when fundSavings != null:
return fundSavings(_that.assetId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SavingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SavingsEvent.started()';
}


}




/// @nodoc


class _FundSavings implements SavingsEvent {
  const _FundSavings({required this.assetId, required this.amount});
  

 final  String assetId;
 final  double amount;

/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundSavingsCopyWith<_FundSavings> get copyWith => __$FundSavingsCopyWithImpl<_FundSavings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FundSavings&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,assetId,amount);

@override
String toString() {
  return 'SavingsEvent.fundSavings(assetId: $assetId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$FundSavingsCopyWith<$Res> implements $SavingsEventCopyWith<$Res> {
  factory _$FundSavingsCopyWith(_FundSavings value, $Res Function(_FundSavings) _then) = __$FundSavingsCopyWithImpl;
@useResult
$Res call({
 String assetId, double amount
});




}
/// @nodoc
class __$FundSavingsCopyWithImpl<$Res>
    implements _$FundSavingsCopyWith<$Res> {
  __$FundSavingsCopyWithImpl(this._self, this._then);

  final _FundSavings _self;
  final $Res Function(_FundSavings) _then;

/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assetId = null,Object? amount = null,}) {
  return _then(_FundSavings(
assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
