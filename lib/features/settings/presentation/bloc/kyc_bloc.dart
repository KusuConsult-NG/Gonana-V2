import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/kyc_repository.dart';
import 'kyc_event.dart';
import 'kyc_state.dart';

@injectable
class KycBloc extends Bloc<KycEvent, KycState> {
  final KycRepository _repository;

  KycBloc(this._repository) : super(const KycState.initial()) {
    on<KycSubmitEvent>((event, emit) async {
      emit(const KycState.loading());
      final result = await _repository.submitKyc(
        idType: event.idType,
        idNumber: event.idNumber,
      );
      result.fold(
        (error) => emit(KycState.error(error)),
        (_) => emit(const KycState.success()),
      );
    });
  }
}
