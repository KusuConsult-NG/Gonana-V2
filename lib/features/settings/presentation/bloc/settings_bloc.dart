import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(const SettingsState.initial()) {
    on<Started>(_onStarted);
    on<LogoutRequested>(_onLogoutRequested);
    on<UpdateProfile>(_onUpdateProfile);
    on<ChangePasswordRequested>(_onChangePassword);
    on<ChangePinRequested>(_onChangePin);
    on<ToggleBiometricsRequested>(_onToggleBiometrics);
  }

  Future<void> _onChangePassword(
    ChangePasswordRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());
    final result = await _repository.changePassword(
      event.oldPassword,
      event.newPassword,
    );
    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (_) => add(const Started()), // Refresh profile if needed or just success
    );
  }

  Future<void> _onChangePin(
    ChangePinRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());
    final result = await _repository.changePin(event.oldPin, event.newPin);
    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (_) => add(const Started()),
    );
  }

  Future<void> _onToggleBiometrics(
    ToggleBiometricsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    // Optimistic toggle could be done here if state had biometricsEnabled field
    final result = await _repository.toggleBiometrics(event.enabled);
    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (_) => add(const Started()),
    );
  }

  Future<void> _onStarted(Started event, Emitter<SettingsState> emit) async {
    emit(const SettingsState.loading());
    final result = await _repository.getUserProfile();
    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (user) => emit(SettingsState.loaded(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());
    final result = await _repository.logout();
    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (_) => emit(const SettingsState.loggedOut()),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());

    // 1. Handle Photo Upload if exists
    String? newPhotoUrl;
    if (event.profilePhoto != null) {
      final photoResult = await _repository.updateProfilePhoto(
        event.profilePhoto!,
      );
      photoResult.fold(
        (failure) => emit(SettingsState.error(failure)),
        (url) => newPhotoUrl = url,
      );
      final isError = state.maybeMap(error: (_) => true, orElse: () => false);
      if (isError) return; // Stop if photo upload failed
    }

    // 2. Update Profile Data
    // We need current user data to construct the Entity.
    // Since we are in Bloc, we 'could' rely on repository to have it or fetch it first.
    // Better to fetch current profile to get ID etc.
    final currentUserResult = await _repository.getUserProfile();

    await currentUserResult.fold(
      (failure) async => emit(SettingsState.error(failure)),
      (currentUser) async {
        final updatedUser = currentUser.copyWith(
          // UserEntity needs copyWith too? Or cast to Model?
          // Limitation: UserEntity might not have copyWith.
          // We can assume Repos accept Entity and we just create a new one or cast.
          firstName: event.firstName,
          lastName: event.lastName,
          profilePhoto:
              newPhotoUrl ??
              currentUser.profilePhoto, // Use new URL or keep old
          bio: event.bio,
          username: event.username,
        );

        final updateResult = await _repository.updateUserProfile(updatedUser);
        updateResult.fold(
          (failure) => emit(SettingsState.error(failure)),
          (_) => emit(SettingsState.loaded(updatedUser)),
        );
      },
    );
  }
}
