import 'package:ad_player/features/ad_player/bloc/ad_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ad_player_playlist_image.dart';
import 'ad_player_playlist_video.dart';

class AdPlayerPlaylist extends StatefulWidget {
  const AdPlayerPlaylist({
    super.key,
    required this.playlist,
  });

  final List<String> playlist;

  @override
  State<AdPlayerPlaylist> createState() => _AdPlayerPlaylistState();
}

class _AdPlayerPlaylistState extends State<AdPlayerPlaylist> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdPlayerBloc>(
      create: (context) => AdPlayerBloc(_controller),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.playlist.map((url) {
          if (url.contains('.mp4') || url.contains('.webm')) {
            return AdPlayerPlaylistVideo(url: url);
          }
          return AdPlayerPlaylistImage(url: url);
        }).toList(),
      ),
    );
  }
}
