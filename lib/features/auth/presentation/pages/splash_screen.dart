// features/auth/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/routes/routes_names.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
 }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    Modular.to.pushReplacementNamed(AppRoutes.onboarding);
  /*   final localData = sl<AuthLocalDataSource>();

    if (await localData.getToken() != null ||
        await localData.getCountryCode() != '') {
      final  country_code = await localData.getCountryCode();
      final  token = await localData.getToken();
          print('country_code: $country_code');
          print('country_code: $token');
      HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
      homeBloc.add(GetHomeDataEvent());

      // Wait until HomeBloc state becomes GetHomeDataSuccess
      await for (final state in homeBloc.stream) {
        if (state is GetHomeDataSuccess) {
          Modular.to.pushReplacementNamed(AppRoutes.homeLayout);
          break;
        }
      }
    }
    else {
      Modular.to.pushReplacementNamed(AppRoutes.newOrOldUserScreen);
    } */
  }

  @override
  void dispose() {
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AssetManger.logo,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
