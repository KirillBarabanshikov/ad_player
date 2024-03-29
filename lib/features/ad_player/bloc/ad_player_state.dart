part of 'ad_player_bloc.dart';

@JsonSerializable()
class AdPlayerState extends Equatable {
  const AdPlayerState({
    this.advertisement,
    this.settings,
    this.isLoading = false,
    this.error = '',
  });

  final AdvertisementModel? advertisement;
  final SettingsModel? settings;
  final bool isLoading;
  final String error;

  AdPlayerState copyWith({
    AdvertisementModel? advertisement,
    SettingsModel? settings,
    bool isLoading = false,
    String error = '',
  }) {
    return AdPlayerState(
      advertisement: advertisement,
      settings: settings ?? this.settings,
      isLoading: isLoading,
      error: error,
    );
  }

  factory AdPlayerState.fromJson(Map<String, dynamic> json) =>
      _$AdPlayerStateFromJson(json);

  Map<String, dynamic> toJson() => _$AdPlayerStateToJson(this);

  @override
  List<Object?> get props => [advertisement, settings, isLoading, error];
}
