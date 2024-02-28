import 'package:flutter/material.dart';

import '../repository/ad_player_repository.dart';
import '../repository/models/playlist_model.dart';
import 'ad_player_playlist.dart';

class AdPlayerWidget extends StatefulWidget {
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
  State<AdPlayerWidget> createState() => _AdPlayerWidgetState();
}

class _AdPlayerWidgetState extends State<AdPlayerWidget> {
  late Future<PlaylistModel> _futurePlaylist;

  @override
  void initState() {
    super.initState();
    _futurePlaylist = AdPlayerRepository().getPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlaylistModel>(
      future: _futurePlaylist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AdPlayerPlaylist(playlist: snapshot.data!.assets);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
