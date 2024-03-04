import 'package:json_annotation/json_annotation.dart';

part 'advertisement_model.g.dart';

@JsonSerializable()
class AdvertisementModel {
  const AdvertisementModel({
    required this.id,
    required this.name,
    required this.dateBegin,
    required this.dateEnd,
    required this.interval,
    required this.types,
    required this.images,
  });

  final int id;
  final String name;
  final DateTime dateBegin;
  final DateTime dateEnd;
  final int interval;
  final List<String> types;
  final List<ImageModel> images;

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);
}

@JsonSerializable()
class ImageModel {
  const ImageModel({
    required this.id,
    required this.name,
    required this.url,
  });

  final int id;
  final String name;
  final String url;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
