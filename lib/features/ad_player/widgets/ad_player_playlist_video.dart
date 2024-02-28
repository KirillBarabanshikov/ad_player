import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../bloc/ad_player_bloc.dart';

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
    _controller.initialize().then((_) {
      setState(() {});
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          BlocProvider.of<AdPlayerBloc>(context).add(AdPlayerNextPage());
        }
      });
      _controller.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
