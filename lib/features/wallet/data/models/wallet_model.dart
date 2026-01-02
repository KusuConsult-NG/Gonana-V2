import '../../domain/entities/wallet_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel extends WalletEntity {
  const WalletModel({
    required super.balanceNgn,
    required super.cryptoBalanceCcd,
    required super.cryptoBalanceEth,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  factory WalletModel.fromFirestore(DocumentSnapshot doc) {
    return WalletModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
