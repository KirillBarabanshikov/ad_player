import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:video_player/video_player.dart';

class AdPlayerPlaylistVideo extends StatefulWidget {
  const AdPlayerPlaylistVideo({
    super.key,
    required this.url,
    required this.changePage,
    required this.controller,
  });

  final File url;
  final void Function(Duration duration) changePage;
  final VideoPlayerController controller;

  @override
  State<AdPlayerPlaylistVideo> createState() => _AdPlayerPlaylistVideoState();
}

class _AdPlayerPlaylistVideoState extends State<AdPlayerPlaylistVideo> {
  @override
  void initState() {
    super.initState();
    widget.controller.seekTo(Duration.zero);
    widget.controller.play();
    widget.changePage(widget.controller.value.duration);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          )
        : Container();
  }
}
