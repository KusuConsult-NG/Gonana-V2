import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../settings/domain/entities/user_entity.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<Started>(_onStarted);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<BiometricLoginRequested>(_onBiometricLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onStarted(Started event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.getCurrentAuthentication();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (auth) => emit(AuthState.authenticated(auth)),
    );
  }

  Future<void> _onBiometricLoginRequested(
    BiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.authenticateBiometric();
    result.fold((failure) => emit(AuthState.error(failure)), (success) {
      if (success) {
        // In a real app, you might fetch user details after biometric success
        // For mock, we'll re-use the sign-in mock user logic or create a similar one
        // But AuthRepository.authenticateBiometric returns bool.
        // We need an AuthEntity to be 'authenticated'.
        // Let's modify repository to return AuthEntity or fetch it here.
        // For simplicity in this mock, let's call signIn with dummy creds or create a user.

        // Better approach for Mock: Have repo return AuthEntity on biometric success?
        // Or just manually create one here for the mock.
        const user = UserEntity(
          id: 'user_bio_789',
          email: 'biometric@user.com',
          firstName: 'Bio',
          lastName: 'User',
          profilePhoto: 'https://i.pravatar.cc/300',
          accountType: 'User',
          phone: '+000 000 0000',
          emailActivated: true,
        );
        emit(
          const AuthState.authenticated(
            AuthEntity(user: user, token: 'mock_bio_token'),
          ),
        );
      } else {
        emit(const AuthState.error('Biometric authentication failed'));
      }
    });
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.signIn(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (String failure) => emit(AuthState.error(failure)),
      (AuthEntity auth) => emit(AuthState.authenticated(auth)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.signUp(
      firstName: event.firstName,
      lastName: event.lastName,
      phoneNumber: event.phoneNumber,
      email: event.email,
      password: event.password,
      country: event.country,
    );
    result.fold(
      (String failure) => emit(AuthState.error(failure)),
      (AuthEntity auth) => emit(AuthState.authenticated(auth)),
    );
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.forgotPassword(email: event.email);
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (_) => emit(const AuthState.forgotPasswordSent()),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    await _repository.signOut();
    emit(const AuthState.unauthenticated());
  }
}
