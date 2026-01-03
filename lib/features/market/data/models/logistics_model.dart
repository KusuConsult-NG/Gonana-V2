import 'package:json_annotation/json_annotation.dart';

part 'logistics_model.g.dart';

@JsonSerializable()
class LogisticsModel {
  final String id;
  final String name;
  final double price;
  final String estimatedDelivery;
  final String? logoUrl;

  const LogisticsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.estimatedDelivery,
    this.logoUrl,
  });

  factory LogisticsModel.fromJson(Map<String, dynamic> json) =>
      _$LogisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogisticsModelToJson(this);
}
