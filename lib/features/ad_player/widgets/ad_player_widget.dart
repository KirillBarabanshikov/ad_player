import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/ad_player_bloc.dart';
import '../repository/repository.dart';
import 'ad_player_playlist.dart';

class AdPlayerWidget extends StatefulWidget {
  const AdPlayerWidget({
    super.key,
    required this.apiKey,
    required this.shopId,
    required this.timeUpdate,
  });

  final String apiKey;
  final int shopId;
  final String timeUpdate;

  @override
  State<AdPlayerWidget> createState() => _AdPlayerWidgetState();
}

class _AdPlayerWidgetState extends State<AdPlayerWidget> {
  final _adPlayerBloc = AdPlayerBloc(GetIt.I.get<AdPlayerRepository>());
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _getAdvertisement();
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      _getAdvertisement();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _getAdvertisement() {
    _adPlayerBloc.add(AdPlayerGetAdEvent(
      id: widget.shopId,
      apiKey: widget.apiKey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap: () {
        print('right click');
      },
      child: BlocProvider<AdPlayerBloc>(
        create: (context) => _adPlayerBloc,
        child: BlocBuilder<AdPlayerBloc, AdPlayerState>(
          bloc: _adPlayerBloc,
          builder: (context, state) {
            if (state is AdPlayerLoadedState) {
              return AdPlayerPlaylist(advertisement: state.advertisement);
            }

            if (state is AdPlayerLoadingFailure) {
              return Center(child: Text('${state.exception}'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
