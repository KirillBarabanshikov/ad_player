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
