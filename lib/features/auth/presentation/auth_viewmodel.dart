import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcw/core/shared/extensions/cubit_extensions.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/permission_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class AuthViewModel {
  AuthViewModel(this.context);

  final BuildContext context;
  int secondsRemaining = 30;
  Timer? timer;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final firstNameController = TextEditingController(text: userData?.firstName);
  final lastNameController = TextEditingController(text: userData?.lastName);
  final phoneController = TextEditingController(text: userData?.phone);
  String? imagePath;

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
    otpController.dispose();
    timer?.cancel();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          await ToastUtil.show(data.message ?? 'OTP sent to your email');
          LoadingUtil.close();
          Zap.toNamed(
            AppRoutes.oTPVerificationScreen,
            arguments: email,
          );
        } else {
          ToastUtil.show(data.message ?? 'Failed to send OTP', true);
        }
      } catch (e) {
        LoadingUtil.close();
        logger.e(e);
        ToastUtil.show('Failed to send OTP', true);
      }
    }
  }

  // Verification OTP

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        context
            .read<AuthCubit>()
            .update(AuthOTPRemainingTime(secondsRemaining));
      } else {
        timer.cancel();
      }
    });
  }

  void onResendPressed(String email) async {
    LoadingUtil.show();
    try {
      final data = await context.read<AuthCubit>().forgetPassword(email);
      LoadingUtil.close();
      await ToastUtil.show(
        data.message ?? 'OTP sent to your email',
        data.isError,
      );
      secondsRemaining = 30;
      startTimer();
      LoadingUtil.close();
    } catch (e) {
      LoadingUtil.close();
      logger.e(e);
      ToastUtil.show('Failed to send OTP', true);
    }
  }

  void onVerifyOTP(String email) async {
    final otp = otpController.text.trim();
    logger.d(otp);
    if (otp.isEmpty) {
      ToastUtil.show('OTP is required', true);
    } else if (otp.length >= 8) {
      await context.read<AuthCubit>().verifyToken(email, otp);
    } else {
      ToastUtil.show('Please enter a valid OTP', true);
    }
  }


}
