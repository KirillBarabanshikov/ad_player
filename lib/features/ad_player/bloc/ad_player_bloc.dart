import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../repository/ad_player_repository.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

part 'ad_player_bloc.g.dart';

class AdPlayerBloc extends HydratedBloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc({
    required this.adPlayerRepository,
    required this.cacheManager,
  }) : super(const AdPlayerState()) {
    on<AdPlayerGetAdEvent>(_onGetAd);
    on<AdPlayerRefetchEvent>(_onRefetch);
    on<AdPlayerSetSettingsEvent>(_onSetSettings);
  }

  final AdPlayerRepository adPlayerRepository;
  final CacheManager cacheManager;

  _onGetAd(AdPlayerGetAdEvent event, Emitter<AdPlayerState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await clear();
      await cacheManager.emptyCache();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final advertisement = await adPlayerRepository
          .getAdvertisementByDrugstoreId(event.settings);
      prefs.setInt('lastFetchDay', DateTime.now().day);
      emit(state.copyWith(
        advertisement: advertisement,
        isLoading: false,
        error: '',
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  _onRefetch(AdPlayerRefetchEvent event, Emitter<AdPlayerState> emit) {
    if (state.settings != null) {
      add(AdPlayerGetAdEvent(settings: state.settings!));
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
