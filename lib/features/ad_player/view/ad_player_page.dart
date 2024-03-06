import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/ad_player_bloc.dart';
import '../widgets/widgets.dart';

class AdPlayerPage extends StatefulWidget {
  const AdPlayerPage({super.key});

  @override
  State<AdPlayerPage> createState() => _AdPlayerPageState();
}

class _AdPlayerPageState extends State<AdPlayerPage> {
  @override
  void initState() {
    super.initState();
    _refetch();
  }

  void _refetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('lastFetchTime') != null) {
      DateTime lastFetchTime =
          DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastFetchTime')!);
      DateTime now = DateTime.now();
      if (now.difference(lastFetchTime).inDays >= 1) {
        if (!mounted) return;
        context.read<AdPlayerBloc>().add(const AdPlayerRefetchEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return const SettingsFormDialog();
            },
          );
        },
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: BlocConsumer<AdPlayerBloc, AdPlayerState>(
            bloc: context.read<AdPlayerBloc>(),
            listenWhen: (previous, current) {
              return previous.settings != current.settings;
            },
            listener: (context, state) {
              if (state.settings != null) {
                context
                    .read<AdPlayerBloc>()
                    .add(AdPlayerGetAdEvent(settings: state.settings!));
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.error.isNotEmpty) {
                return Center(child: Text(state.error));
              }

              if (state.settings == null) {
                return const Center(child: Text('settings is null'));
              } else {
                return const AdPlayerWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
