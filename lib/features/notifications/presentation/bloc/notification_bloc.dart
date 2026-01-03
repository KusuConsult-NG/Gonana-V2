import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  NotificationBloc(this._repository)
    : super(const NotificationState.initial()) {
    on<LoadNotifications>((event, emit) async {
      emit(const NotificationState.loading());
      try {
        final notifications = await _repository.getNotifications();
        emit(NotificationState.loaded(notifications));
      } catch (e) {
        emit(NotificationState.error(e.toString()));
      }
    });
  }
}
