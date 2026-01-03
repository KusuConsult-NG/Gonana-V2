// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent()';
}


}

/// @nodoc
class $OrderEventCopyWith<$Res>  {
$OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}


/// Adds pattern-matching-related methods to [OrderEvent].
extension OrderEventPatterns on OrderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadBuyerOrders value)?  loadBuyerOrders,TResult Function( LoadSellerSales value)?  loadSellerSales,TResult Function( CreateOrder value)?  createOrder,TResult Function( UpdateStatus value)?  updateStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that);case LoadSellerSales() when loadSellerSales != null:
return loadSellerSales(_that);case CreateOrder() when createOrder != null:
return createOrder(_that);case UpdateStatus() when updateStatus != null:
return updateStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadBuyerOrders value)  loadBuyerOrders,required TResult Function( LoadSellerSales value)  loadSellerSales,required TResult Function( CreateOrder value)  createOrder,required TResult Function( UpdateStatus value)  updateStatus,}){
final _that = this;
switch (_that) {
case LoadBuyerOrders():
return loadBuyerOrders(_that);case LoadSellerSales():
return loadSellerSales(_that);case CreateOrder():
return createOrder(_that);case UpdateStatus():
return updateStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadBuyerOrders value)?  loadBuyerOrders,TResult? Function( LoadSellerSales value)?  loadSellerSales,TResult? Function( CreateOrder value)?  createOrder,TResult? Function( UpdateStatus value)?  updateStatus,}){
final _that = this;
switch (_that) {
case LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that);case LoadSellerSales() when loadSellerSales != null:
return loadSellerSales(_that);case CreateOrder() when createOrder != null:
return createOrder(_that);case UpdateStatus() when updateStatus != null:
return updateStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String buyerId)?  loadBuyerOrders,TResult Function( String sellerId)?  loadSellerSales,TResult Function( OrderEntity order)?  createOrder,TResult Function( String orderId,  OrderStatus status)?  updateStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that.buyerId);case LoadSellerSales() when loadSellerSales != null:
return loadSellerSales(_that.sellerId);case CreateOrder() when createOrder != null:
return createOrder(_that.order);case UpdateStatus() when updateStatus != null:
return updateStatus(_that.orderId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String buyerId)  loadBuyerOrders,required TResult Function( String sellerId)  loadSellerSales,required TResult Function( OrderEntity order)  createOrder,required TResult Function( String orderId,  OrderStatus status)  updateStatus,}) {final _that = this;
switch (_that) {
case LoadBuyerOrders():
return loadBuyerOrders(_that.buyerId);case LoadSellerSales():
return loadSellerSales(_that.sellerId);case CreateOrder():
return createOrder(_that.order);case UpdateStatus():
return updateStatus(_that.orderId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String buyerId)?  loadBuyerOrders,TResult? Function( String sellerId)?  loadSellerSales,TResult? Function( OrderEntity order)?  createOrder,TResult? Function( String orderId,  OrderStatus status)?  updateStatus,}) {final _that = this;
switch (_that) {
case LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that.buyerId);case LoadSellerSales() when loadSellerSales != null:
return loadSellerSales(_that.sellerId);case CreateOrder() when createOrder != null:
return createOrder(_that.order);case UpdateStatus() when updateStatus != null:
return updateStatus(_that.orderId,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class LoadBuyerOrders implements OrderEvent {
  const LoadBuyerOrders(this.buyerId);
  

 final  String buyerId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadBuyerOrdersCopyWith<LoadBuyerOrders> get copyWith => _$LoadBuyerOrdersCopyWithImpl<LoadBuyerOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadBuyerOrders&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId));
}


@override
int get hashCode => Object.hash(runtimeType,buyerId);

@override
String toString() {
  return 'OrderEvent.loadBuyerOrders(buyerId: $buyerId)';
}


}

/// @nodoc
abstract mixin class $LoadBuyerOrdersCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory $LoadBuyerOrdersCopyWith(LoadBuyerOrders value, $Res Function(LoadBuyerOrders) _then) = _$LoadBuyerOrdersCopyWithImpl;
@useResult
$Res call({
 String buyerId
});




}
/// @nodoc
class _$LoadBuyerOrdersCopyWithImpl<$Res>
    implements $LoadBuyerOrdersCopyWith<$Res> {
  _$LoadBuyerOrdersCopyWithImpl(this._self, this._then);

  final LoadBuyerOrders _self;
  final $Res Function(LoadBuyerOrders) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? buyerId = null,}) {
  return _then(LoadBuyerOrders(
null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadSellerSales implements OrderEvent {
  const LoadSellerSales(this.sellerId);
  

 final  String sellerId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadSellerSalesCopyWith<LoadSellerSales> get copyWith => _$LoadSellerSalesCopyWithImpl<LoadSellerSales>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSellerSales&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}


@override
int get hashCode => Object.hash(runtimeType,sellerId);

@override
String toString() {
  return 'OrderEvent.loadSellerSales(sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class $LoadSellerSalesCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory $LoadSellerSalesCopyWith(LoadSellerSales value, $Res Function(LoadSellerSales) _then) = _$LoadSellerSalesCopyWithImpl;
@useResult
$Res call({
 String sellerId
});




}
/// @nodoc
class _$LoadSellerSalesCopyWithImpl<$Res>
    implements $LoadSellerSalesCopyWith<$Res> {
  _$LoadSellerSalesCopyWithImpl(this._self, this._then);

  final LoadSellerSales _self;
  final $Res Function(LoadSellerSales) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sellerId = null,}) {
  return _then(LoadSellerSales(
null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateOrder implements OrderEvent {
  const CreateOrder(this.order);
  

 final  OrderEntity order;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderCopyWith<CreateOrder> get copyWith => _$CreateOrderCopyWithImpl<CreateOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrder&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderEvent.createOrder(order: $order)';
}


}

/// @nodoc
abstract mixin class $CreateOrderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory $CreateOrderCopyWith(CreateOrder value, $Res Function(CreateOrder) _then) = _$CreateOrderCopyWithImpl;
@useResult
$Res call({
 OrderEntity order
});




}
/// @nodoc
class _$CreateOrderCopyWithImpl<$Res>
    implements $CreateOrderCopyWith<$Res> {
  _$CreateOrderCopyWithImpl(this._self, this._then);

  final CreateOrder _self;
  final $Res Function(CreateOrder) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(CreateOrder(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,
  ));
}


}

/// @nodoc


class UpdateStatus implements OrderEvent {
  const UpdateStatus(this.orderId, this.status);
  

 final  String orderId;
 final  OrderStatus status;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateStatusCopyWith<UpdateStatus> get copyWith => _$UpdateStatusCopyWithImpl<UpdateStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateStatus&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,status);

@override
String toString() {
  return 'OrderEvent.updateStatus(orderId: $orderId, status: $status)';
}


}

/// @nodoc
abstract mixin class $UpdateStatusCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory $UpdateStatusCopyWith(UpdateStatus value, $Res Function(UpdateStatus) _then) = _$UpdateStatusCopyWithImpl;
@useResult
$Res call({
 String orderId, OrderStatus status
});




}
/// @nodoc
class _$UpdateStatusCopyWithImpl<$Res>
    implements $UpdateStatusCopyWith<$Res> {
  _$UpdateStatusCopyWithImpl(this._self, this._then);

  final UpdateStatus _self;
  final $Res Function(UpdateStatus) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? status = null,}) {
  return _then(UpdateStatus(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,
  ));
}


}

// dart format on
