part of 'ad_player_bloc.dart';

class AdPlayerState extends Equatable {
  const AdPlayerState({
    this.playlist = const [],
    this.currentPage = 0,
  });

  final List<String> playlist;
  final int currentPage;

  AdPlayerState copyWith({
    List<String>? playlist,
    int? currentPage,
  }) {
    return AdPlayerState(
      playlist: playlist ?? this.playlist,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [playlist, currentPage];
}
