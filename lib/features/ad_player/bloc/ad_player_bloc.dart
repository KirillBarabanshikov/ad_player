import 'package:ad_player/features/ad_player/ad_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

class AdPlayerBloc extends Bloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this._adPlayerRepository) : super(AdPlayerInitial()) {
    on<AdPlayerGetAdEvent>(_onGetAd);
  }

  final AdPlayerRepository _adPlayerRepository;

  _onGetAd(AdPlayerGetAdEvent event, Emitter<AdPlayerState> emit) async {
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
