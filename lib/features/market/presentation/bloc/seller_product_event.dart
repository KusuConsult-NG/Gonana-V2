import 'package:freezed_annotation/freezed_annotation.dart';

part 'seller_product_event.freezed.dart';

@freezed
class SellerProductEvent with _$SellerProductEvent {
  const factory SellerProductEvent.loadMyProducts() = _LoadMyProducts;
  const factory SellerProductEvent.deleteProduct(String productId) =
      _DeleteProduct;
}
