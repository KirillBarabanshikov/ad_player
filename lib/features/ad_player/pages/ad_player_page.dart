import 'package:flutter/material.dart';

import '../widgets/ad_player_widget.dart';

class AdPlayerPage extends StatelessWidget {
  const AdPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: AdPlayerWidget(
          keyApi: '',
          shopId: '',
          timeUpdate: '',
        ),
      ),
    );
  }
}
