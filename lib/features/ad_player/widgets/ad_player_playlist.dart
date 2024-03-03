import 'dart:async';
import 'package:ad_player/utils/is_video_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../repository/repository.dart';
import 'ad_player_playlist_image.dart';
import 'ad_player_playlist_video.dart';

class AdPlayerPlaylist extends StatefulWidget {
  const AdPlayerPlaylist({
    super.key,
    required this.advertisement,
  });

  final AdvertisementModel advertisement;

  @override
  State<AdPlayerPlaylist> createState() => _AdPlayerPlaylistState();
}

class _AdPlayerPlaylistState extends State<AdPlayerPlaylist> {
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: widget.advertisement.interval),
      (timer) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutExpo,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final currentIndex = index % widget.advertisement.images.length;
        final url = widget.advertisement.images[currentIndex].url;

        return FutureBuilder<File>(
          future: GetIt.I.get<CacheManager>().getSingleFile(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final file = snapshot.data!;
              final basename = file.basename;
              final isVideo = isVideoFile(basename);

              if (isVideo) {
                return AdPlayerPlaylistVideo(file: file);
              }

              return AdPlayerPlaylistImage(file: file);
            }

            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
