import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_state.freezed.dart';

@freezed
class KycState with _$KycState {
  const factory KycState.initial() = _Initial;
  const factory KycState.loading() = _Loading;
  const factory KycState.success() = _Success;
  const factory KycState.error(String message) = _Error;
}
