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
  Future<void> _refetchAd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? lastFetchTime = prefs.getInt('lastFetchTime') != null
        ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastFetchTime')!)
        : null;

    if (lastFetchTime != null &&
        DateTime.now().difference(lastFetchTime).inDays >= 1) {
      if (!mounted) return;
      context.read<AdPlayerBloc>().add(const AdPlayerRefetchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _refetchAd(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const AdPlayerView();
      },
    );
  }
}

class AdPlayerView extends StatefulWidget {
  const AdPlayerView({super.key});

  @override
  State<AdPlayerView> createState() => _AdPlayerViewState();
}

class _AdPlayerViewState extends State<AdPlayerView> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const SettingsFormDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTap: () => _showDialog(),
        onLongPress: () => _showDialog(),
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
