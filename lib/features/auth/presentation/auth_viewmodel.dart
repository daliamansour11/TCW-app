import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/extensions/cubit_extensions.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';


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
  void register() {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final name = firstNameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();


    final data = {
      'first_name':name,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm_password':confirmPassword,
    };

    context.read<AuthCubit>().register(data);
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
      try {
        LoadingUtil.show();
        await context.read<AuthCubit>().forgetPassword(email);
        LoadingUtil.close();
      } catch (e) {
        LoadingUtil.close();
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
      await context.read<AuthCubit>().forgetPassword(email);
      LoadingUtil.close();
      ToastUtil.show('OTP sent to your email', false);
      secondsRemaining = 30;
      startTimer();
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
    } else if (otp.length >= 5) {
      await context.read<AuthCubit>().verifyToken(email, otp);
    } else {
      ToastUtil.show('Please enter a valid OTP', true);
    }
  }

  void onResetPassword(String email ,String token) async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    if (password != confirmPassword) {
      ToastUtil.show('Passwords do not match', true);
      return;
    }
    LoadingUtil.show();
    try {
       await context.read<AuthCubit>().resetPassword({
        'email': email,
        'token': token,
        'password': password,
        'confirm_password': confirmPassword,
      });
      LoadingUtil.close();
    } catch (e) {
      LoadingUtil.close();
    }
  }
}
