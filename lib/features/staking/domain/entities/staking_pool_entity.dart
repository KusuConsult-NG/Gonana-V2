import 'package:equatable/equatable.dart';

class StakingPoolEntity extends Equatable {
  final String id;
  final String name;
  final double apy;
  final String duration;
  final double minStakingAmount;

  const StakingPoolEntity({
    required this.id,
    required this.name,
    required this.apy,
    required this.duration,
    required this.minStakingAmount,
  });

  @override
  List<Object?> get props => [id, name, apy, duration, minStakingAmount];
}
