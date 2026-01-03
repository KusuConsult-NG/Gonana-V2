import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_event.freezed.dart';

@freezed
class SavingsEvent with _$SavingsEvent {
  const factory SavingsEvent.started() = _Started;
  const factory SavingsEvent.fundSavings({
    required String assetId,
    required double amount,
  }) = _FundSavings;
}
