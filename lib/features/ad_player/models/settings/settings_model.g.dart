// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      apiKey: json['apiKey'] as String,
      shopId: json['shopId'] as String,
      timeUpdate: json['timeUpdate'] as String,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'shopId': instance.shopId,
      'timeUpdate': instance.timeUpdate,
    };
