part of 'ad_player_bloc.dart';

class AdPlayerState extends Equatable {
  const AdPlayerState({
    required this.currentPage,
  });

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}
