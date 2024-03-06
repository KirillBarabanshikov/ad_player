import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel extends Equatable {
  const SettingsModel({
    required this.apiKey,
    required this.shopId,
    required this.timeUpdate,
  });

  final String apiKey;
  final String shopId;
  final String timeUpdate;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  @override
  List<Object?> get props => [apiKey, shopId, timeUpdate];
}
