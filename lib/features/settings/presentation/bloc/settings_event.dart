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
  }) = UpdateProfile;
}
