import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/rounded_text_filed.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/presentation/auth_viewmodel.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zapx/zapx.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late AuthViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AuthViewModel(context);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingUtil.show();
        } else {
          if (LoadingUtil.isLoading) {
            LoadingUtil.close();
          }

          if (state is AuthPasswordResetTokenSent) {
            ToastUtil.show(state.message);
            Future.delayed(const Duration(milliseconds: 500), () {
              Zap.toNamed(
                AppRoutes.oTPVerificationScreen,
                arguments: viewModel.emailController.text.trim(),
              );
            });
          } else if (state is AuthError) {
            ToastUtil.show(state.message, true);
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Forgot Password',
              style: context.textTheme.headlineMedium),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Enter the email we will send the OTP in this email to reset your password',
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  RoundedTextField(
                    hint: 'Enter your E-mail',
                    icon: Icons.email_outlined,
                    controller: viewModel.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    onPressed: () => viewModel.onSendForgetPassword(),
                    title: 'Continue',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}