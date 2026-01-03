// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staking_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StakingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StakingEvent()';
}


}

/// @nodoc
class $StakingEventCopyWith<$Res>  {
$StakingEventCopyWith(StakingEvent _, $Res Function(StakingEvent) __);
}


/// Adds pattern-matching-related methods to [StakingEvent].
extension StakingEventPatterns on StakingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _StakeTokens value)?  stakeTokens,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _StakeTokens() when stakeTokens != null:
return stakeTokens(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _StakeTokens value)  stakeTokens,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _StakeTokens():
return stakeTokens(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _StakeTokens value)?  stakeTokens,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _StakeTokens() when stakeTokens != null:
return stakeTokens(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String poolId,  double amount)?  stakeTokens,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _StakeTokens() when stakeTokens != null:
return stakeTokens(_that.poolId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String poolId,  double amount)  stakeTokens,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _StakeTokens():
return stakeTokens(_that.poolId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String poolId,  double amount)?  stakeTokens,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _StakeTokens() when stakeTokens != null:
return stakeTokens(_that.poolId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements StakingEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StakingEvent.started()';
}


}




/// @nodoc


class _StakeTokens implements StakingEvent {
  const _StakeTokens({required this.poolId, required this.amount});
  

 final  String poolId;
 final  double amount;

/// Create a copy of StakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StakeTokensCopyWith<_StakeTokens> get copyWith => __$StakeTokensCopyWithImpl<_StakeTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StakeTokens&&(identical(other.poolId, poolId) || other.poolId == poolId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,poolId,amount);

@override
String toString() {
  return 'StakingEvent.stakeTokens(poolId: $poolId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$StakeTokensCopyWith<$Res> implements $StakingEventCopyWith<$Res> {
  factory _$StakeTokensCopyWith(_StakeTokens value, $Res Function(_StakeTokens) _then) = __$StakeTokensCopyWithImpl;
@useResult
$Res call({
 String poolId, double amount
});




}
/// @nodoc
class __$StakeTokensCopyWithImpl<$Res>
    implements _$StakeTokensCopyWith<$Res> {
  __$StakeTokensCopyWithImpl(this._self, this._then);

  final _StakeTokens _self;
  final $Res Function(_StakeTokens) _then;

/// Create a copy of StakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,Object? amount = null,}) {
  return _then(_StakeTokens(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
