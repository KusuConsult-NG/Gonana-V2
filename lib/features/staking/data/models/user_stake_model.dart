import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_stake_entity.dart';

part 'user_stake_model.g.dart';

@JsonSerializable()
class UserStakeModel extends UserStakeEntity {
  const UserStakeModel({
    required super.id,
    required super.poolId,
    required super.poolName,
    required super.amount,
    required super.startDate,
    required super.endDate,
    required super.expectedReturn,
  });

  factory UserStakeModel.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic data) {
      if (data is Timestamp) return data.toDate();
      if (data is String) return DateTime.parse(data);
      return DateTime.now();
    }

    return UserStakeModel(
      id: json['id'] as String? ?? '',
      poolId: json['poolId'] as String,
      poolName: json['poolName'] as String,
      amount: (json['amount'] as num).toDouble(),
      startDate: parseDate(json['startDate']),
      endDate: parseDate(json['endDate']),
      expectedReturn: (json['expectedReturn'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => _$UserStakeModelToJson(this);

  factory UserStakeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserStakeModel.fromJson(data..['id'] = doc.id);
  }

  // ignore: unused_element
  void _ensureGeneratedCodeUsed() {
    _$UserStakeModelFromJson({});
  }
}
