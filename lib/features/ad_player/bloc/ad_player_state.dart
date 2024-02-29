part of 'ad_player_bloc.dart';

class AdPlayerState extends Equatable {
  const AdPlayerState({
    this.playlist = const [],
  });

  final List<String> playlist;

  @override
  List<Object?> get props => [playlist];
}
