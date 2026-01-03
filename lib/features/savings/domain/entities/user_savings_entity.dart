import 'package:equatable/equatable.dart';

class UserSavingsEntity extends Equatable {
  final String id;
  final String assetId;
  final String assetName;
  final double balance;
  final double accruedProfit;
  final DateTime startDate;
  final DateTime? nextPayoutDate;

  const UserSavingsEntity({
    required this.id,
    required this.assetId,
    required this.assetName,
    required this.balance,
    required this.accruedProfit,
    required this.startDate,
    this.nextPayoutDate,
  });

  @override
  List<Object?> get props => [
    id,
    assetId,
    assetName,
    balance,
    accruedProfit,
    startDate,
    nextPayoutDate,
  ];
}
