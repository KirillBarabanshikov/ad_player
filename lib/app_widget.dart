import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/ad_player/ad_player.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: GetIt.I.get<AdPlayerRepository>(),
      child: BlocProvider(
        create: (context) => AdPlayerBloc(context.read<AdPlayerRepository>()),
        child: const AppWidgetView(),
      ),
    );
  }
}

class AppWidgetView extends StatelessWidget {
  const AppWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ad player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const AdPlayerPage(),
    );
  }
}
