// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketEvent()';
}


}

/// @nodoc
class $MarketEventCopyWith<$Res>  {
$MarketEventCopyWith(MarketEvent _, $Res Function(MarketEvent) __);
}


/// Adds pattern-matching-related methods to [MarketEvent].
extension MarketEventPatterns on MarketEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadData value)?  loadData,TResult Function( _SearchProducts value)?  searchProducts,TResult Function( _FilterProducts value)?  filterProducts,TResult Function( _CreateProduct value)?  createProduct,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadData() when loadData != null:
return loadData(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _FilterProducts() when filterProducts != null:
return filterProducts(_that);case _CreateProduct() when createProduct != null:
return createProduct(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadData value)  loadData,required TResult Function( _SearchProducts value)  searchProducts,required TResult Function( _FilterProducts value)  filterProducts,required TResult Function( _CreateProduct value)  createProduct,}){
final _that = this;
switch (_that) {
case _LoadData():
return loadData(_that);case _SearchProducts():
return searchProducts(_that);case _FilterProducts():
return filterProducts(_that);case _CreateProduct():
return createProduct(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadData value)?  loadData,TResult? Function( _SearchProducts value)?  searchProducts,TResult? Function( _FilterProducts value)?  filterProducts,TResult? Function( _CreateProduct value)?  createProduct,}){
final _that = this;
switch (_that) {
case _LoadData() when loadData != null:
return loadData(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _FilterProducts() when filterProducts != null:
return filterProducts(_that);case _CreateProduct() when createProduct != null:
return createProduct(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadData,TResult Function( String query)?  searchProducts,TResult Function( String category)?  filterProducts,TResult Function( String name,  double price,  String description,  String location,  double availableQuantity,  String unit,  double? shippingPrice,  List<File> images)?  createProduct,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadData() when loadData != null:
return loadData();case _SearchProducts() when searchProducts != null:
return searchProducts(_that.query);case _FilterProducts() when filterProducts != null:
return filterProducts(_that.category);case _CreateProduct() when createProduct != null:
return createProduct(_that.name,_that.price,_that.description,_that.location,_that.availableQuantity,_that.unit,_that.shippingPrice,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadData,required TResult Function( String query)  searchProducts,required TResult Function( String category)  filterProducts,required TResult Function( String name,  double price,  String description,  String location,  double availableQuantity,  String unit,  double? shippingPrice,  List<File> images)  createProduct,}) {final _that = this;
switch (_that) {
case _LoadData():
return loadData();case _SearchProducts():
return searchProducts(_that.query);case _FilterProducts():
return filterProducts(_that.category);case _CreateProduct():
return createProduct(_that.name,_that.price,_that.description,_that.location,_that.availableQuantity,_that.unit,_that.shippingPrice,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadData,TResult? Function( String query)?  searchProducts,TResult? Function( String category)?  filterProducts,TResult? Function( String name,  double price,  String description,  String location,  double availableQuantity,  String unit,  double? shippingPrice,  List<File> images)?  createProduct,}) {final _that = this;
switch (_that) {
case _LoadData() when loadData != null:
return loadData();case _SearchProducts() when searchProducts != null:
return searchProducts(_that.query);case _FilterProducts() when filterProducts != null:
return filterProducts(_that.category);case _CreateProduct() when createProduct != null:
return createProduct(_that.name,_that.price,_that.description,_that.location,_that.availableQuantity,_that.unit,_that.shippingPrice,_that.images);case _:
  return null;

}
}

}

/// @nodoc


class _LoadData implements MarketEvent {
  const _LoadData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketEvent.loadData()';
}


}




/// @nodoc


class _SearchProducts implements MarketEvent {
  const _SearchProducts(this.query);
  

 final  String query;

/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchProductsCopyWith<_SearchProducts> get copyWith => __$SearchProductsCopyWithImpl<_SearchProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchProducts&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'MarketEvent.searchProducts(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchProductsCopyWith<$Res> implements $MarketEventCopyWith<$Res> {
  factory _$SearchProductsCopyWith(_SearchProducts value, $Res Function(_SearchProducts) _then) = __$SearchProductsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchProductsCopyWithImpl<$Res>
    implements _$SearchProductsCopyWith<$Res> {
  __$SearchProductsCopyWithImpl(this._self, this._then);

  final _SearchProducts _self;
  final $Res Function(_SearchProducts) _then;

/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchProducts(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterProducts implements MarketEvent {
  const _FilterProducts(this.category);
  

 final  String category;

/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterProductsCopyWith<_FilterProducts> get copyWith => __$FilterProductsCopyWithImpl<_FilterProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterProducts&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'MarketEvent.filterProducts(category: $category)';
}


}

/// @nodoc
abstract mixin class _$FilterProductsCopyWith<$Res> implements $MarketEventCopyWith<$Res> {
  factory _$FilterProductsCopyWith(_FilterProducts value, $Res Function(_FilterProducts) _then) = __$FilterProductsCopyWithImpl;
@useResult
$Res call({
 String category
});




}
/// @nodoc
class __$FilterProductsCopyWithImpl<$Res>
    implements _$FilterProductsCopyWith<$Res> {
  __$FilterProductsCopyWithImpl(this._self, this._then);

  final _FilterProducts _self;
  final $Res Function(_FilterProducts) _then;

/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(_FilterProducts(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CreateProduct implements MarketEvent {
  const _CreateProduct({required this.name, required this.price, required this.description, required this.location, required this.availableQuantity, required this.unit, this.shippingPrice, final  List<File> images = const []}): _images = images;
  

 final  String name;
 final  double price;
 final  String description;
 final  String location;
 final  double availableQuantity;
 final  String unit;
 final  double? shippingPrice;
 final  List<File> _images;
@JsonKey() List<File> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateProductCopyWith<_CreateProduct> get copyWith => __$CreateProductCopyWithImpl<_CreateProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateProduct&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.availableQuantity, availableQuantity) || other.availableQuantity == availableQuantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.shippingPrice, shippingPrice) || other.shippingPrice == shippingPrice)&&const DeepCollectionEquality().equals(other._images, _images));
}


@override
int get hashCode => Object.hash(runtimeType,name,price,description,location,availableQuantity,unit,shippingPrice,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'MarketEvent.createProduct(name: $name, price: $price, description: $description, location: $location, availableQuantity: $availableQuantity, unit: $unit, shippingPrice: $shippingPrice, images: $images)';
}


}

/// @nodoc
abstract mixin class _$CreateProductCopyWith<$Res> implements $MarketEventCopyWith<$Res> {
  factory _$CreateProductCopyWith(_CreateProduct value, $Res Function(_CreateProduct) _then) = __$CreateProductCopyWithImpl;
@useResult
$Res call({
 String name, double price, String description, String location, double availableQuantity, String unit, double? shippingPrice, List<File> images
});




}
/// @nodoc
class __$CreateProductCopyWithImpl<$Res>
    implements _$CreateProductCopyWith<$Res> {
  __$CreateProductCopyWithImpl(this._self, this._then);

  final _CreateProduct _self;
  final $Res Function(_CreateProduct) _then;

/// Create a copy of MarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? description = null,Object? location = null,Object? availableQuantity = null,Object? unit = null,Object? shippingPrice = freezed,Object? images = null,}) {
  return _then(_CreateProduct(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,availableQuantity: null == availableQuantity ? _self.availableQuantity : availableQuantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,shippingPrice: freezed == shippingPrice ? _self.shippingPrice : shippingPrice // ignore: cast_nullable_to_non_nullable
as double?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<File>,
  ));
}


}

/// @nodoc
mixin _$MarketState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketState()';
}


}

/// @nodoc
class $MarketStateCopyWith<$Res>  {
$MarketStateCopyWith(MarketState _, $Res Function(MarketState) __);
}


/// Adds pattern-matching-related methods to [MarketState].
extension MarketStatePatterns on MarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductEntity> products,  List<ProductEntity> hotDeals)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.hotDeals);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductEntity> products,  List<ProductEntity> hotDeals)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.products,_that.hotDeals);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductEntity> products,  List<ProductEntity> hotDeals)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.hotDeals);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements MarketState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketState.initial()';
}


}




/// @nodoc


class _Loading implements MarketState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketState.loading()';
}


}




/// @nodoc


class _Loaded implements MarketState {
  const _Loaded({required final  List<ProductEntity> products, required final  List<ProductEntity> hotDeals}): _products = products,_hotDeals = hotDeals;
  

 final  List<ProductEntity> _products;
 List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<ProductEntity> _hotDeals;
 List<ProductEntity> get hotDeals {
  if (_hotDeals is EqualUnmodifiableListView) return _hotDeals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hotDeals);
}


/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._hotDeals, _hotDeals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_hotDeals));

@override
String toString() {
  return 'MarketState.loaded(products: $products, hotDeals: $hotDeals)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $MarketStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductEntity> products, List<ProductEntity> hotDeals
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? hotDeals = null,}) {
  return _then(_Loaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,hotDeals: null == hotDeals ? _self._hotDeals : hotDeals // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

/// @nodoc


class _Error implements MarketState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of MarketState
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
  return 'MarketState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $MarketStateCopyWith<$Res> {
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

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
