part of 'ad_player_bloc.dart';

abstract class AdPlayerEvent extends Equatable {
  const AdPlayerEvent();
}

class AdPlayerFetchAdEvent extends AdPlayerEvent {
  const AdPlayerFetchAdEvent({required this.settings});

  final SettingsModel settings;

  @override
  List<Object?> get props => [settings];
}
