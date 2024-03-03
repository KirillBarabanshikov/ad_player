part of 'ad_player_bloc.dart';

abstract class AdPlayerState extends Equatable {}

class AdPlayerInitial extends AdPlayerState {
  @override
  List<Object?> get props => [];
}

class AdPlayerLoadingState extends AdPlayerState {
  @override
  List<Object?> get props => [];
}

class AdPlayerLoadedState extends AdPlayerState {
  AdPlayerLoadedState({required this.advertisement});

  final AdvertisementModel advertisement;

  @override
  List<Object?> get props => [advertisement];
}

class AdPlayerLoadingFailure extends AdPlayerState {
  AdPlayerLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
