part of 'ad_player_bloc.dart';

abstract class AdPlayerEvent extends Equatable {
  const AdPlayerEvent();
}

class AdPlayerGetAdEvent extends AdPlayerEvent {
  const AdPlayerGetAdEvent({required this.settings});

  final SettingsModel settings;

  @override
  List<Object?> get props => [settings];
}

class AdPlayerSetSettingsEvent extends AdPlayerEvent {
  const AdPlayerSetSettingsEvent({required this.settings});

  final SettingsModel settings;

  @override
  List<Object?> get props => [settings];
}
