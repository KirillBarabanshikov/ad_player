import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advertisement_model.g.dart';

@JsonSerializable()
class AdvertisementModel extends Equatable {
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

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    if (!(json['types'] as List<dynamic>).contains('ANDROID')) {
      throw const FormatException('Invalid advertisement type');
    }

    return _$AdvertisementModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);

  @override
  List<Object?> get props =>
      [id, name, dateBegin, dateEnd, interval, types, images];
}

@JsonSerializable()
class ImageModel extends Equatable {
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

  @override
  List<Object?> get props => [id, name, url];
}
