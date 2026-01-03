import 'package:equatable/equatable.dart';

abstract class KycEvent extends Equatable {
  const KycEvent();
}

class KycSubmitEvent extends KycEvent {
  final String idType;
  final String idNumber;

  const KycSubmitEvent({required this.idType, required this.idNumber});

  @override
  List<Object?> get props => [idType, idNumber];
}
