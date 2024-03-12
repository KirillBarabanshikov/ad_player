import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

class PlayerPlaylistImage extends StatelessWidget {
  const PlayerPlaylistImage({
    super.key,
    required this.file,
  });

  final File file;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      fit: BoxFit.cover,
    );
  }
}
