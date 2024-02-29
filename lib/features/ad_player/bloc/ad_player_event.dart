part of 'ad_player_bloc.dart';

abstract class AdPlayerEvent extends Equatable {
  const AdPlayerEvent();
}

class AdPlayerGetPlaylistEvent extends AdPlayerEvent {
  @override
  List<Object?> get props => [];
}
