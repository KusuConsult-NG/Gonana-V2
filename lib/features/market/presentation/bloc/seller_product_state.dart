import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'seller_product_state.freezed.dart';

@freezed
class SellerProductState with _$SellerProductState {
  const factory SellerProductState.initial() = _Initial;
  const factory SellerProductState.loading() = _Loading;
  const factory SellerProductState.loaded(List<ProductEntity> products) =
      _Loaded;
  const factory SellerProductState.error(String message) = _Error;
  const factory SellerProductState.success(String message) = _Success;
}
