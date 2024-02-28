import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ad_player_event.dart';

part 'ad_player_state.dart';

class AdPlayerBloc extends Bloc<AdPlayerEvent, AdPlayerState> {
  AdPlayerBloc(this.controller) : super(const AdPlayerState(currentPage: 0)) {
    on<AdPlayerNextPage>((event, emit) {
      emit(AdPlayerState(
          currentPage: state.currentPage < 5 ? state.currentPage + 1 : 0));
      controller.animateToPage(
        state.currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  final PageController controller;
}
