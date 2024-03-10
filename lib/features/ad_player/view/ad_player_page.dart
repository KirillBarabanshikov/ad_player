import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ad_player_bloc.dart';
import '../widgets/widgets.dart';

class AdPlayerPage extends StatefulWidget {
  const AdPlayerPage({super.key});

  @override
  State<AdPlayerPage> createState() => _AdPlayerPageState();
}

class _AdPlayerPageState extends State<AdPlayerPage> {
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
                return Container();
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
