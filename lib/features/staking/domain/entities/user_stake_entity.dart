import 'package:equatable/equatable.dart';

class UserStakeEntity extends Equatable {
  final String id;
  final String poolId;
  final String poolName;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final double expectedReturn;

  const UserStakeEntity({
    required this.id,
    required this.poolId,
    required this.poolName,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.expectedReturn,
  });

  @override
  List<Object?> get props => [
    id,
    poolId,
    poolName,
    amount,
    startDate,
    endDate,
    expectedReturn,
  ];
}
