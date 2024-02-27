class PlaylistModel {
  const PlaylistModel({required this.assets});

  final List<String> assets;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
        assets: (json['playlist'] as List<dynamic>)
            .map((e) => e as String)
            .toList());
  }
}
