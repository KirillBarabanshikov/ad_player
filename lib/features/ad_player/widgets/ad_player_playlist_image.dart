import 'package:flutter/material.dart';

class AdPlayerPlaylistImage extends StatefulWidget {
  const AdPlayerPlaylistImage({
    super.key,
    required this.url,
    required this.changePage,
  });

  final String url;
  final void Function(Duration duration) changePage;

  @override
  State<AdPlayerPlaylistImage> createState() => _AdPlayerPlaylistImageState();
}

class _AdPlayerPlaylistImageState extends State<AdPlayerPlaylistImage> {
  @override
  void initState() {
    super.initState();
    widget.changePage(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      fit: BoxFit.cover,
    );
  }
}
