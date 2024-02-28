part of 'ad_player_bloc.dart';

abstract class AdPlayerEvent extends Equatable {
  const AdPlayerEvent();

  @override
  List<Object?> get props => [];
}

class AdPlayerNextPage extends AdPlayerEvent {}
