import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = Started;
  const factory SettingsEvent.logoutRequested() = LogoutRequested;
  const factory SettingsEvent.updateProfile({
    required String firstName,
    required String lastName,
    File? profilePhoto,
    String? bio,
    String? username,
  }) = UpdateProfile;

  const factory SettingsEvent.changePasswordRequested({
    required String oldPassword,
    required String newPassword,
  }) = ChangePasswordRequested;

  const factory SettingsEvent.changePinRequested({
    required String oldPin,
    required String newPin,
  }) = ChangePinRequested;

  const factory SettingsEvent.toggleBiometricsRequested(bool enabled) =
      ToggleBiometricsRequested;
}
