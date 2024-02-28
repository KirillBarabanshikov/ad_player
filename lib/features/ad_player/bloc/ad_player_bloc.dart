import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/ad_player_repository.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

class AdPlayerBloc extends Bloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this._adPlayerRepository) : super(const AdPlayerState()) {
    on<AdPlayerGetPlaylistEvent>(_onGetPlaylist);
    on<AdPlayerChangePageEvent>(_onChangePage);
  }

  final AdPlayerRepository _adPlayerRepository;

  _onGetPlaylist(
      AdPlayerGetPlaylistEvent event, Emitter<AdPlayerState> emit) async {
    final playlist = await _adPlayerRepository.getPlaylist();
    emit(state.copyWith(playlist: playlist.assets));
  }

  _onChangePage(AdPlayerChangePageEvent event, Emitter<AdPlayerState> emit) {
    final currentPage = state.currentPage < state.playlist.length - 1
        ? state.currentPage + 1
        : 0;
    emit(state.copyWith(currentPage: currentPage));
  }
}
