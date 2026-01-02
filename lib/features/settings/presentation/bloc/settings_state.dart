import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.loaded(UserEntity user) = _Loaded;
  const factory SettingsState.loggedOut() =
      _LoggedOut; // State to trigger navigation to login
  const factory SettingsState.error(String message) = _Error;
}
