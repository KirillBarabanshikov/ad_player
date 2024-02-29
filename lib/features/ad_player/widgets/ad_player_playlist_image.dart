import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

class AdPlayerPlaylistImage extends StatefulWidget {
  const AdPlayerPlaylistImage({
    super.key,
    required this.url,
    required this.changePage,
  });

  final File url;
  final void Function(Duration duration) changePage;

  @override
  State<AdPlayerPlaylistImage> createState() => _AdPlayerPlaylistImageState();
}

class _AdPlayerPlaylistImageState extends State<AdPlayerPlaylistImage> {
  @override
  void initState() {
    super.initState();
    widget.changePage(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Image.file(
      widget.url,
      fit: BoxFit.cover,
    );
  }
}
