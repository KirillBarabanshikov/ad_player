import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ad_player_bloc.dart';
import 'ad_player_playlist.dart';

class AdPlayerWidget extends StatefulWidget {
  const AdPlayerWidget({super.key});

  @override
  State<AdPlayerWidget> createState() => _AdPlayerWidgetState();
}

class _AdPlayerWidgetState extends State<AdPlayerWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimerRefetch();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimerRefetch() {
    final adPlayerBloc = context.read<AdPlayerBloc>();

    final currentDate = DateTime.now();
    final selectedDate = adPlayerBloc.state.settings?.timeUpdate;

    if (selectedDate != null) {
      final currentMin = currentDate.hour * 60 + currentDate.minute;
      final selectedMin = selectedDate.hour * 60 + selectedDate.minute;
      const oneDayMin = 24 * 60;

      final difference = currentMin - selectedMin;
      final duration =
          difference >= 0 ? oneDayMin - difference : difference.abs();

      _timer = Timer(Duration(minutes: duration), () {
        adPlayerBloc.add(const AdPlayerRefetchEvent());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdPlayerBloc, AdPlayerState>(
      bloc: context.read<AdPlayerBloc>(),
      builder: (context, state) {
        if (state.advertisement != null) {
          return AdPlayerPlaylist(advertisement: state.advertisement!);
        }

        return Container();
      },
    );
  }
}
