import 'dart:async';

import 'package:flutter/material.dart';

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
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (_currentIndex < widget.playlist.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
      });
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: widget.playlist.map((url) {
        if (url.contains('.mp4')) {
          return AdPlayerPlaylistVideo(url: url);
        }
        return AdPlayerPlaylistImage(url: url);
      }).toList(),
    );
  }
}
