import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

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
  final cacheManager = DefaultCacheManager();
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentPageIndex = 0;
  final Map<int, VideoPlayerController> _controllers = {};

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
      setState(() {
        _currentPageIndex = _currentPageIndex < widget.playlist.length - 1
            ? _currentPageIndex + 1
            : 0;
      });
      _controller.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  Future<FileInfo> _downloadFile(String url) async {
    FileInfo? file = await cacheManager.getFileFromCache(url);

    file ??= await cacheManager.downloadFile(url);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final url = widget.playlist[index];
          return FutureBuilder<FileInfo>(
            future: _downloadFile(url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Center(child: Text('${snapshot.data!.file}'));
                final filePath = snapshot.data!.file;

                if (filePath.path.contains('.mp4') ||
                    filePath.path.contains('.webm')) {
                  if (!_controllers.containsKey(index)) {
                    _controllers[index] = VideoPlayerController.file(filePath);
                    _controllers[index]?.initialize().then((_) {
                      setState(() {});
                    });
                  }

                  return AdPlayerPlaylistVideo(
                    controller: _controllers[index]!,
                    url: filePath,
                    changePage: _changePage,
                  );
                }
                return AdPlayerPlaylistImage(
                  url: filePath,
                  changePage: _changePage,
                );
              }

              return Container();
            },
          );
        },
        childCount: widget.playlist.length,
        addAutomaticKeepAlives: true,
      ),
    );
  }
}
