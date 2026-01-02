import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = Started;
  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = SignInRequested;
  const factory AuthEvent.signUpRequested({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String country,
  }) = SignUpRequested;
  const factory AuthEvent.forgotPasswordRequested({required String email}) =
      ForgotPasswordRequested;
  const factory AuthEvent.biometricLoginRequested() = BiometricLoginRequested;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
