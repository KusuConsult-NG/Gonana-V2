import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/savings_asset_entity.dart';

part 'savings_asset_model.g.dart';

@JsonSerializable()
class SavingsAssetModel extends SavingsAssetEntity {
  const SavingsAssetModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.apy,
    required super.minDuration,
    required super.description,
  });

  factory SavingsAssetModel.fromJson(Map<String, dynamic> json) =>
      _$SavingsAssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavingsAssetModelToJson(this);

  factory SavingsAssetModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SavingsAssetModel.fromJson(data..['id'] = doc.id);
  }
}
