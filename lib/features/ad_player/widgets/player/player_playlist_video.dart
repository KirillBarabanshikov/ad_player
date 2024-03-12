import 'package:ad_player/utils/generate_video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';

class PlayerPlaylistVideo extends StatefulWidget {
  const PlayerPlaylistVideo({
    super.key,
    required this.file,
  });

  final File file;

  @override
  State<PlayerPlaylistVideo> createState() => _PlayerPlaylistVideoState();
}

class _PlayerPlaylistVideoState extends State<PlayerPlaylistVideo> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  final _cacheManager = GetIt.I.get<CacheManager>();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file);
    _initializeVideoPlayerFuture = _initializeVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    await _videoController.initialize();
    await Future.delayed(const Duration(milliseconds: 600));
    await _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          return AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          );
        }

        return FutureBuilder<File>(
          future: generateVideoThumbnail(widget.file, _cacheManager),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.file(
                snapshot.data!,
                fit: BoxFit.fill,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
