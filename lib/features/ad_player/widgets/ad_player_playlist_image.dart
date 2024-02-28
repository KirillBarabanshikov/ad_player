import 'dart:async';

import 'package:ad_player/features/ad_player/bloc/ad_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdPlayerPlaylistImage extends StatefulWidget {
  const AdPlayerPlaylistImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<AdPlayerPlaylistImage> createState() => _AdPlayerPlaylistImageState();
}

class _AdPlayerPlaylistImageState extends State<AdPlayerPlaylistImage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      BlocProvider.of<AdPlayerBloc>(context).add(AdPlayerNextPage());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      fit: BoxFit.cover,
    );
  }
}
