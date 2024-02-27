import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdPlayerPlaylistVideo extends StatefulWidget {
  const AdPlayerPlaylistVideo({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<AdPlayerPlaylistVideo> createState() => _AdPlayerPlaylistVideoState();
}

class _AdPlayerPlaylistVideoState extends State<AdPlayerPlaylistVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container();
  }
}
