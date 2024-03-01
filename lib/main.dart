import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import 'app_widget.dart';
import 'features/ad_player/repository/ad_player_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  final getIt = GetIt.I;

  getIt.registerSingleton(CacheManager(Config(
    'playlistCache',
    stalePeriod: const Duration(days: 1),
  )));
  getIt.registerSingleton(AdPlayerRepository());

  runApp(const AppWidget());
}
