import 'dart:async';

import 'package:ad_player/utils/is_video_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../../models/models.dart';
import 'player_playlist_image.dart';
import 'player_playlist_video.dart';

class PlayerPlaylist extends StatefulWidget {
  const PlayerPlaylist({
    super.key,
    required this.advertisement,
  });

  final AdvertisementModel advertisement;

  @override
  State<PlayerPlaylist> createState() => _PlayerPlaylistState();
}

class _PlayerPlaylistState extends State<PlayerPlaylist> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

  @override
  void didUpdateWidget(PlayerPlaylist oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.advertisement != widget.advertisement) {
      _pageController.dispose();
      _timer.cancel();
      _currentPage = 0;
      _pageController = PageController(initialPage: _currentPage);
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: widget.advertisement.interval),
      (timer) {
        _currentPage = (_currentPage + 1) % widget.advertisement.images.length;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutExpo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final url = widget.advertisement.images[_currentPage].url;

        return FutureBuilder<File>(
          future: GetIt.I.get<CacheManager>().getSingleFile(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final file = snapshot.data!;
              final basename = file.basename;
              final isVideo = isVideoFile(basename);

              if (isVideo) {
                return PlayerPlaylistVideo(file: file);
              }

              return PlayerPlaylistImage(file: file);
            }

            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
