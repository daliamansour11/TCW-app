import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/rounded_text_filed.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/presentation/auth_viewmodel.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zapx/zapx.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        } else if (state is AuthRegistered) {
          LoadingUtil.close();
          ToastUtil.show('auth.welcome'.tr(args: [state.user.name]));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Zap.offAllNamed(AppRoutes.homeLayout);
          });
        } else if (state is AuthError) {
          LoadingUtil.close();
          ToastUtil.show(state.message, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('auth.register'.tr(), style: context.textTheme.headlineMedium),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    RoundedTextField(
                      hint: 'auth.enter_name'.tr(),
                      icon: Icons.person_outline,
                      controller: viewModel.firstNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'auth.name_required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    RoundedTextField(
                      hint: 'auth.enter_email'.tr(),
                      icon: Icons.email_outlined,
                      controller: viewModel.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'auth.email_required'.tr();
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                            .hasMatch(value)) {
                          return 'auth.email_invalid'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    RoundedTextField(
                      hint: 'auth.enter_phone'.tr(),
                      icon: Icons.phone,
                      controller: viewModel.phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'auth.phone_required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    RoundedTextField(
                      hint: 'auth.password'.tr(),
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: viewModel.passwordController,
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
                    const SizedBox(height: 24),

                    RoundedTextField(
                      hint: 'auth.retype_password'.tr(),
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: viewModel.confirmPasswordController,
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
                    SizedBox(height: context.propHeight(160)),

                    CustomButton(
                      height: context.propHeight(50),
                      onPressed: viewModel.register,
                      title: 'auth.register'.tr(),
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: context.propWidth(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('auth.have_account'.tr()),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.loginPage);
                          },
                          child: Text(
                            'auth.login'.tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
