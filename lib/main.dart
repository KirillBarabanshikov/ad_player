import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_widget.dart';
import 'features/ad_player/ad_player.dart';

final getIt = GetIt.I;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  getIt.registerSingleton(CacheManager(Config(
    'advertisementCache',
    stalePeriod: const Duration(days: 1),
  )));
  getIt.registerSingleton(Dio(BaseOptions(
    baseUrl: 'http://192.168.0.103:5051/',
  )));
  getIt.registerSingleton(AdPlayerRepository(getIt.get<Dio>()));

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const AppWidget());
}
