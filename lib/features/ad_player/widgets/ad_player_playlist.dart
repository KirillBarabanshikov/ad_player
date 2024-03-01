import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

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
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
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
        final url = widget.playlist[index % widget.playlist.length];
        return FutureBuilder<File>(
          future: GetIt.I.get<CacheManager>().getSingleFile(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final file = snapshot.data!;
              final basename = file.basename;

              if (basename.contains('.mp4') || basename.contains('.webm')) {
                return AdPlayerPlaylistVideo(file: file);
              }
              return AdPlayerPlaylistImage(file: file);
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          },
        );
      },
    );
  }
}
