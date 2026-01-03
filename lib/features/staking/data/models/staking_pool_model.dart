import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/staking_pool_entity.dart';

part 'staking_pool_model.g.dart';

@JsonSerializable()
class StakingPoolModel extends StakingPoolEntity {
  const StakingPoolModel({
    required super.id,
    required super.name,
    required super.apy,
    required super.duration,
    required super.minStakingAmount,
  });

  factory StakingPoolModel.fromJson(Map<String, dynamic> json) =>
      _$StakingPoolModelFromJson(json);

  Map<String, dynamic> toJson() => _$StakingPoolModelToJson(this);

  factory StakingPoolModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StakingPoolModel.fromJson(data..['id'] = doc.id);
  }
}
