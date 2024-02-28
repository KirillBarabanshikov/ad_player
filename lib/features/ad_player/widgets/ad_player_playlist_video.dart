import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdPlayerPlaylistVideo extends StatefulWidget {
  const AdPlayerPlaylistVideo({
    super.key,
    required this.url,
    required this.changePage,
  });

  final String url;
  final void Function(Duration duration) changePage;

  @override
  State<AdPlayerPlaylistVideo> createState() => _AdPlayerPlaylistVideoState();
}

class _AdPlayerPlaylistVideoState extends State<AdPlayerPlaylistVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await _controller.initialize();
    setState(() {});
    _controller.play();
    widget.changePage(_controller.value.duration);
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
