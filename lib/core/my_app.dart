import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/theme/app_theme.dart';
import 'package:toastification/toastification.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart' show XMaterialApp;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: AssetUtils.translationsPath,
      fallbackLocale: const Locale('ar'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale('en'),
      child: Builder(builder: (context) {
        return ZapSizer(
          builder: (context, constraints) => ToastificationWrapper(
            child: XMaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'tcw',
              
              theme: AppTheme(context).theme,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerDelegate: Modular.routerDelegate,
              routeInformationParser: Modular.routeInformationParser,
            ),
          ),
        );
      }),
    );
  }
}
