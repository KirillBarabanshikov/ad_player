import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/ad_player_repository.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

class AdPlayerBloc extends Bloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this._adPlayerRepository) : super(const AdPlayerState()) {
    on<AdPlayerGetPlaylistEvent>(_onGetPlaylist);
  }

  final AdPlayerRepository _adPlayerRepository;

  _onGetPlaylist(
      AdPlayerGetPlaylistEvent event, Emitter<AdPlayerState> emit) async {
    final playlist = await _adPlayerRepository.getPlaylist();
    emit(AdPlayerState(playlist: playlist.assets));
  }
}
