// main.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/core/my_app.dart';
import 'package:tcw/init.dart';
import 'package:tcw/core/routes/module.dart';
//import 'injection_container.dart' as di;
import 'package:device_preview/device_preview.dart';
import 'package:zapx/zapx.dart';

import 'core/utils/asset_utils.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization before using it
  await EasyLocalization.ensureInitialized();

  await init();
  Modular.setNavigatorKey(Tools.navigatorKey);

  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  final prefs = await SharedPreferences.getInstance();
  final savedLangCode = prefs.getString('saved_locale') ?? 'en';
  final savedLocale = Locale(savedLangCode);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AssetUtils.translationsPath,
      fallbackLocale: const Locale('ar'),
      startLocale: savedLocale,
      child: DevicePreview(
        enabled: false,
        builder: (context) => ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
