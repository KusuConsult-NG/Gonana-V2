import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_savings_entity.dart';

part 'user_savings_model.g.dart';

@JsonSerializable()
class UserSavingsModel extends UserSavingsEntity {
  const UserSavingsModel({
    required super.id,
    required super.assetId,
    required super.assetName,
    required super.balance,
    required super.accruedProfit,
    required super.startDate,
    super.nextPayoutDate,
  });

  factory UserSavingsModel.fromJson(Map<String, dynamic> json) {
    DateTime? startDate;
    if (json['startDate'] is Timestamp) {
      startDate = (json['startDate'] as Timestamp).toDate();
    } else if (json['startDate'] is String) {
      startDate = DateTime.parse(json['startDate'] as String);
    }

    DateTime? nextPayoutDate;
    if (json['nextPayoutDate'] is Timestamp) {
      nextPayoutDate = (json['nextPayoutDate'] as Timestamp).toDate();
    } else if (json['nextPayoutDate'] is String) {
      nextPayoutDate = DateTime.parse(json['nextPayoutDate'] as String);
    }

    return UserSavingsModel(
      id: json['id'] as String? ?? '',
      assetId: json['assetId'] as String,
      assetName: json['assetName'] as String,
      balance: (json['balance'] as num).toDouble(),
      accruedProfit: (json['accruedProfit'] as num).toDouble(),
      startDate: startDate ?? DateTime.now(),
      nextPayoutDate: nextPayoutDate,
    );
  }

  Map<String, dynamic> toJson() => _$UserSavingsModelToJson(this);

  factory UserSavingsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserSavingsModel.fromJson(data..['id'] = doc.id);
  }

  // ignore: unused_element
  void _ensureGeneratedCodeUsed() {
    _$UserSavingsModelFromJson({});
  }
}
