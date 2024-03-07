import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_widget.dart';
import 'setup_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await setupDependencies();

  runApp(const AppWidget());
}
