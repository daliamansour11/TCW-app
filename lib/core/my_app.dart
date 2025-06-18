
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: AssetManger.translationsPath,
            saveLocale: true,
            fallbackLocale: const Locale('ar'),
            supportedLocales: const [Locale('en'), Locale('ar')],
            startLocale: const Locale('en'),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'tcw',
            theme: AppTheme(context).theme,
             localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
          );
        }
      ),
    );
  }
}


