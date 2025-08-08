// features/auth/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:tcw/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zapx/zapx.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }


  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();

    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (!hasSeenOnboarding) {
      Zap.offAllNamed(AppRoutes.onboarding);
      return;
    }
    final user = await AuthRepositoryImpl(AuthRemoteDatasourceImpl(),AuthLocalDatasourceImpl()).getLoggedUser();

    if (user != null) {
      userData = user;
      Zap.offAllNamed(AppRoutes.homeLayout);
    } else {
      Zap.offAllNamed(AppRoutes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AssetUtils.logo,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
