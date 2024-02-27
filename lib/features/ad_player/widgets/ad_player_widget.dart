import 'package:flutter/material.dart';

import 'ad_player_playlist.dart';

final playlist = [
  "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1587370560942-ad2a04eabb6d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
];

class AdPlayerWidget extends StatelessWidget {
  const AdPlayerWidget({
    super.key,
    required this.keyApi,
    required this.shopId,
    required this.timeUpdate,
  });

  final String keyApi;
  final String shopId;
  final String timeUpdate;

  @override
  Widget build(BuildContext context) {
    return AdPlayerPlaylist(playlist: playlist);
  }
}
