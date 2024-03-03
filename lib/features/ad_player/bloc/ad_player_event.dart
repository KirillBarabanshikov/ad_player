part of 'ad_player_bloc.dart';

abstract class AdPlayerEvent extends Equatable {
  const AdPlayerEvent();
}

class AdPlayerGetAdEvent extends AdPlayerEvent {
  const AdPlayerGetAdEvent({
    required this.id,
    required this.apiKey,
  });

  final int id;
  final String apiKey;

  @override
  List<Object?> get props => [id, apiKey];
}
