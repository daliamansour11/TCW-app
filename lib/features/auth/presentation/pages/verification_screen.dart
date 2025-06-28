import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/presentation/auth_viewmodel.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen(this.email, {super.key});
  final String email;
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late AuthViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AuthViewModel(context);
    viewModel.startTimer();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 5,
          children: [
            const CustomText('OTP has been sent to'),
            CustomText(widget.email),
            SizedBox(height: 5.h),
            CustomTextField(
              borderRadius: 12,
              controller: viewModel.otpController,
              hintText: 'Enter OTP',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid digit code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthOTPRemainingTime &&state.seconds!=0) {
                return  CustomText(
                    "00:${state.seconds.toString().padLeft(2, '0')} Sec",
                    color: Colors.grey,
                  );
                }
                return const SizedBox();
              },
            ),
            CustomButton(
              onPressed: () => viewModel.onVerifyOTP(widget.email),
              title: 'Continue',
            ),
            const SizedBox(height: 16),
          BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) => current is AuthOTPRemainingTime,
              builder: (context, state) =>  Text.rich(
              TextSpan(
                text: 'Don’t receive code ? ',
                style: CustomText.style(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Re-send',
                    style: CustomText.style(
                      fontWeight: FontWeight.bold,
                      color: state is AuthOTPRemainingTime && state.seconds == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = viewModel.secondsRemaining == 0
                          ? () => viewModel.onResendPressed(widget.email)
                          : null,
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
