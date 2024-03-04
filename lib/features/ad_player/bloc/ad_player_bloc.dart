import 'package:ad_player/features/ad_player/ad_player.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

class AdPlayerBloc extends HydratedBloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this._adPlayerRepository) : super(AdPlayerInitial()) {
    on<AdPlayerGetAdEvent>(_onGetAd);
  }

  final AdPlayerRepository _adPlayerRepository;

  @override
  AdPlayerState? fromJson(Map<String, dynamic> json) {
    return AdPlayerLoadedState(
      advertisement: AdvertisementModel.fromJson(json),
    );
  }

  @override
  Map<String, dynamic>? toJson(AdPlayerState state) {
    if (state is AdPlayerLoadedState) {
      return state.advertisement.toJson();
    }
  }

  _onGetAd(AdPlayerGetAdEvent event, Emitter<AdPlayerState> emit) async {
    if (state is! AdPlayerLoadedState) {
      try {
        emit(AdPlayerLoadingState());
        final advertisement = await _adPlayerRepository
            .getAdvertisementByDrugstoreId(event.id, event.apiKey);
        emit(AdPlayerLoadedState(advertisement: advertisement));
      } catch (e) {
        emit(AdPlayerLoadingFailure(exception: e));
      }
    }
  }
}
