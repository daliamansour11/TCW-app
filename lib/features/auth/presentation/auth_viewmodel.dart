import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class AuthViewModel {
  AuthViewModel(this.context);

  final BuildContext context;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
  }

  void login() {
    if (!formKey.currentState!.validate()) return;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    context.read<AuthCubit>().login(email, password, rememberMe);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  //Forget Password
  void onSendForgetPassword() async {
    final email = emailController.text.trim();
    if (formKey.currentState?.validate() ?? false) {
      LoadingUtil.show();
      try {
        final data = await context.read<AuthCubit>().forgetPassword(email);
          LoadingUtil.close();
        if (data.isSuccess) {
          ToastUtil.show('OTP sent to your email');
          Zap.toNamed(
            AppRoutes.oTPVerificationScreen,
            arguments: email,
          );
        } else {
          ToastUtil.show(data.errorMessage ?? 'Failed to send OTP',true);
        }
      } catch (e) {
        LoadingUtil.close();
        logger.e(e);
        ToastUtil.show('Failed to send OTP',true);
      }
    }
  }
}
