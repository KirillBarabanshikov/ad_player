import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AdPlayerPlaylistVideo extends StatefulWidget {
  const AdPlayerPlaylistVideo({
    super.key,
    required this.file,
  });

  final File file;

  @override
  State<AdPlayerPlaylistVideo> createState() => _AdPlayerPlaylistVideoState();
}

class _AdPlayerPlaylistVideoState extends State<AdPlayerPlaylistVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final _cacheManager = GetIt.I.get<CacheManager>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);
    _initializeVideoPlayerFuture =
        _controller.initialize().then((value) => _controller.play());
    _getThumb();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getThumb() async {
    var file =
        await _cacheManager.getFileFromCache('thumb_${widget.file.basename}');

    if (file == null) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: widget.file.path,
        imageFormat: ImageFormat.WEBP,
      );

      await _cacheManager.putFile('thumb_${widget.file.basename}', uint8list!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return FutureBuilder<FileInfo?>(
            future:
                _cacheManager.getFileFromCache('thumb_${widget.file.basename}'),
            builder: (context, thumbSnapshot) {
              if (thumbSnapshot.hasData) {
                return Image.file(
                  thumbSnapshot.data!.file,
                  fit: BoxFit.fill,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }
      },
    );
  }
}
