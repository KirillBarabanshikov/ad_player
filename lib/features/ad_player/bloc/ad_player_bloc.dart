import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

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
    on<AdPlayerFetchAdEvent>(_onFetchAd);
  }

  final AdPlayerRepository adPlayerRepository;
  final CacheManager cacheManager;
  Timer? _timer;

  Future<void> _onFetchAd(
    AdPlayerFetchAdEvent event,
    Emitter<AdPlayerState> emit,
  ) async {
    try {
      emit(state.copyWith(settings: event.settings, isLoading: true));
      final advertisements = await adPlayerRepository
          .getAdvertisementByDrugstoreId(event.settings);
      emit(state.copyWith(isLoading: false));
      _refetchAd();
      await _scheduleAd(advertisements, emit);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _refetchAd() {
    _timer?.cancel();

    final settings = state.settings;

    if (settings == null) return;

    final currentSeconds = _getTotalSeconds(DateTime.now());
    int selectedSeconds = _getTotalSeconds(settings.timeUpdate);
    const oneDaySeconds = 24 * 3600;

    if (selectedSeconds <= currentSeconds) {
      selectedSeconds += oneDaySeconds;
    }

    final duration = selectedSeconds - currentSeconds;

    _timer = Timer(Duration(seconds: duration), () {
      add(AdPlayerFetchAdEvent(settings: settings));
    });
  }

  int _getTotalSeconds(DateTime dateTime) {
    return dateTime.hour * 3600 + dateTime.minute * 60 + dateTime.second;
  }

  Future<void> _scheduleAd(
    List<AdvertisementModel> advertisements,
    Emitter<AdPlayerState> emit,
  ) async {
    for (var advertisement in advertisements) {
      if (DateTime.now().isAfter(advertisement.dateEnd)) continue;

      final delayBegin = advertisement.dateBegin.difference(DateTime.now());

      // TODO
      emit(state.copyWith(
        error: 'до начала ${advertisement.name}: $delayBegin',
      ));

      if (delayBegin.isNegative) {
        emit(state.copyWith(advertisement: advertisement));
      } else {
        await Future.delayed(delayBegin);
        emit(state.copyWith(advertisement: advertisement));
      }

      final delayEnd = advertisement.dateEnd.difference(DateTime.now());
      await Future.delayed(delayEnd);
      emit(state.copyWith(advertisement: null));
    }
  }

  @override
  AdPlayerState fromJson(Map<String, dynamic> json) =>
      AdPlayerState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AdPlayerState state) => state.toJson();
}
