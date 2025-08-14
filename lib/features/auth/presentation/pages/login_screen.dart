import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/rounded_text_filed.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/presentation/auth_viewmodel.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        } else if (state is AuthLoggedIn) {
          LoadingUtil.close();
          ToastUtil.show(tr('welcome_user', args: [state.user.name]));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Zap.offAllNamed(AppRoutes.homeLayout);
          });
        } else if (state is AuthError) {
          LoadingUtil.close();
          ToastUtil.show(state.message, true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.propHeight(32)),
                    Center(
                      child: Text(tr('login_page'),
                          style: context.textTheme.headlineMedium),
                    ),
                    SizedBox(height: context.propHeight(32)),

                    RoundedTextField(
                      hint: tr('enter_email'),
                      icon: Icons.email_outlined,
                      controller: viewModel.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('please_enter_email');
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value)) {
                          return tr('enter_valid_email');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedTextField(
                      hint: tr('password'),
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: viewModel.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('please_enter_password');
                        }
                        if (value.length < 6) {
                          return tr('password_min_length');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: AppColors.primaryColor,
                          value: viewModel.rememberMe,
                          onChanged: (value) {
                            setState(() {
                              viewModel.toggleRememberMe(value);
                            });
                          },
                        ),
                        Text(
                          tr('remember_me'),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.forgetPasswordScreen);
                          },
                          child: Text(
                            tr('forgot_password'),
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.propHeight(160)),
                    CustomButton(
                      height: context.propHeight(50),
                      onPressed: viewModel.login,
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: context.propWidth(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      title: tr('log_in'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr('dont_have_account')),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.registerPage);
                          },
                          child: Text(
                            tr('register_now'),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
