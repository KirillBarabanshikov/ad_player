import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/playlist_model.dart';

class AdPlayerRepository {
  Future<PlaylistModel> getPlaylist() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.0.103:3000/playlists'));
      final playlist = PlaylistModel.fromJson(jsonDecode(response.body));
      return playlist;
    } catch (e) {
      throw Exception(e);
    }
  }
}
