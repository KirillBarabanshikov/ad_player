import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AdPlayerPage extends StatelessWidget {
  const AdPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: AdPlayerWidget(
          apiKey: '4a81161c-64c1-46fa-899c-fe77482f7ed3',
          shopId: 13,
          timeUpdate: '',
        ),
      ),
    );
  }
}
