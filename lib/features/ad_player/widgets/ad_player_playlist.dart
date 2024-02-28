import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ad_player_bloc.dart';
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
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer!.cancel();
  }

  void _changePage(Duration duration) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _timer = Timer(duration, () {
      BlocProvider.of<AdPlayerBloc>(context).add(AdPlayerChangePageEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdPlayerBloc, AdPlayerState>(
      listenWhen: (previous, current) {
        return previous.currentPage != current.currentPage;
      },
      listener: (context, state) {
        _controller.animateToPage(
          state.currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      },
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.playlist.map((url) {
          if (url.contains('.mp4') || url.contains('.webm')) {
            return AdPlayerPlaylistVideo(
              url: url,
              changePage: _changePage,
            );
          }
          return AdPlayerPlaylistImage(
            url: url,
            changePage: _changePage,
          );
        }).toList(),
      ),
    );
  }
}
