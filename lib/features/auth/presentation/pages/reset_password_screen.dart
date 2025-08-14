import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/rounded_text_filed.dart';
import 'package:tcw/features/auth/presentation/auth_viewmodel.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('auth.reset_password'.tr(), style: context.textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'auth.enter_new_password'.tr(),
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                RoundedTextField(
                  hint: 'auth.new_password'.tr(),
                  icon: Icons.lock_outline,
                  controller: viewModel.passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.password_required'.tr();
                    }
                    if (value.length < 6) {
                      return 'auth.password_length'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RoundedTextField(
                  hint: 'auth.confirm_password'.tr(),
                  icon: Icons.lock_outline,
                  controller: viewModel.confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.confirm_password_required'.tr();
                    }
                    if (value != viewModel.passwordController.text) {
                      return 'auth.passwords_not_match'.tr();
                    }
                    return null;
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () => viewModel.onResetPassword(widget.email, widget.otp),
                    title: 'auth.continue'.tr(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
