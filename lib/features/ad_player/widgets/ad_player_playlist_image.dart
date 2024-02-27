import 'package:flutter/material.dart';

class AdPlayerPlaylistImage extends StatelessWidget {
  const AdPlayerPlaylistImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
    );
  }
}
