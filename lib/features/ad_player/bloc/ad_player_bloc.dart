import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/models.dart';
import '../repository/ad_player_repository.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

part 'ad_player_bloc.g.dart';

class AdPlayerBloc extends HydratedBloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this._adPlayerRepository) : super(const AdPlayerState()) {
    on<AdPlayerGetAdEvent>(_onGetAd);
    on<AdPlayerSetSettingsEvent>(_onSetSettings);
  }

  final AdPlayerRepository _adPlayerRepository;

  _onGetAd(AdPlayerGetAdEvent event, Emitter<AdPlayerState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final advertisement = await _adPlayerRepository
          .getAdvertisementByDrugstoreId(event.settings);
      emit(state.copyWith(
        advertisement: advertisement,
        isLoading: false,
        error: '',
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  _onSetSettings(AdPlayerSetSettingsEvent event, Emitter<AdPlayerState> emit) {
    emit(state.copyWith(settings: event.settings));
  }

  @override
  AdPlayerState fromJson(Map<String, dynamic> json) =>
      AdPlayerState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AdPlayerState state) => state.toJson();
}
