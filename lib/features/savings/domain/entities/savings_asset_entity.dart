import 'package:equatable/equatable.dart';

class SavingsAssetEntity extends Equatable {
  final String id;
  final String name;
  final String icon;
  final double apy;
  final String minDuration;
  final String description;

  const SavingsAssetEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.apy,
    required this.minDuration,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, icon, apy, minDuration, description];
}
