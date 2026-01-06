import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
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
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
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

    // First, perform biometric authentication
    final biometricResult = await _repository.authenticateBiometric();

    await biometricResult.fold(
      (failure) async {
        emit(AuthState.error(failure));
      },
      (success) async {
        if (!success) {
          emit(const AuthState.error('Biometric authentication failed'));
          return;
        }

        // Biometric authentication succeeded
        // Now fetch the real authenticated user
        final authResult = await _repository.getCurrentAuthentication();

        authResult.fold(
          (failure) {
            // User not logged in or no stored credentials
            emit(
              const AuthState.error(
                'Please login with email and password first to enable biometric authentication',
              ),
            );
          },
          (auth) {
            // Successfully retrieved real user
            emit(AuthState.authenticated(auth));
          },
        );
      },
    );
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
      age: event.age,
      gender: event.gender,
      userType: event.userType,
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

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.signInWithGoogle();
    result.fold(
      (String failure) => emit(AuthState.error(failure)),
      (AuthEntity auth) => emit(AuthState.authenticated(auth)),
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
