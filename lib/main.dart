// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/my_app.dart';
import 'package:tcw/injection_container.dart';
import 'package:tcw/core/routes/module.dart';
//import 'injection_container.dart' as di;
import 'package:device_preview/device_preview.dart';
import 'package:zapx/zapx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Modular.setNavigatorKey(Tools.navigatorKey);
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  ));
}
