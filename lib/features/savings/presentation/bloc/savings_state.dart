import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/savings_asset_entity.dart';
import '../../domain/entities/user_savings_entity.dart';

part 'savings_state.freezed.dart';

@freezed
class SavingsState with _$SavingsState {
  const factory SavingsState.initial() = _Initial;
  const factory SavingsState.loading() = _Loading;
  const factory SavingsState.loaded({
    required List<SavingsAssetEntity> assets,
    required List<UserSavingsEntity> userSavings,
  }) = _Loaded;
  const factory SavingsState.success(String message) = _Success;
  const factory SavingsState.error(String message) = _Error;
}
