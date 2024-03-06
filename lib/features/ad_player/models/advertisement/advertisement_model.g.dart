// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementModel _$AdvertisementModelFromJson(Map<String, dynamic> json) =>
    AdvertisementModel(
      id: json['id'] as int,
      name: json['name'] as String,
      dateBegin: DateTime.parse(json['dateBegin'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      interval: json['interval'] as int,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvertisementModelToJson(AdvertisementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateBegin': instance.dateBegin.toIso8601String(),
      'dateEnd': instance.dateEnd.toIso8601String(),
      'interval': instance.interval,
      'types': instance.types,
      'images': instance.images,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
