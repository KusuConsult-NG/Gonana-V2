import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.loaded({
    @Default([]) List<OrderEntity> orders,
    @Default([]) List<OrderEntity> sales,
  }) = _Loaded;
  const factory OrderState.error(String message) = _Error;
  const factory OrderState.success() = _Success;
}
