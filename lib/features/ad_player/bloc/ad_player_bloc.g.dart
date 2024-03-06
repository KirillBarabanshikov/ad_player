// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_player_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdPlayerState _$AdPlayerStateFromJson(Map<String, dynamic> json) =>
    AdPlayerState(
      advertisement: json['advertisement'] == null
          ? null
          : AdvertisementModel.fromJson(
              json['advertisement'] as Map<String, dynamic>),
      settings: json['settings'] == null
          ? null
          : SettingsModel.fromJson(json['settings'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String? ?? '',
    );

Map<String, dynamic> _$AdPlayerStateToJson(AdPlayerState instance) =>
    <String, dynamic>{
      'advertisement': instance.advertisement,
      'settings': instance.settings,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
