import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          ToastUtil.show('Welcome ${state.user.name}');
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
                      child: Text('Log in Page',
                          style: context.textTheme.headlineMedium),
                    ),
                    SizedBox(height: context.propHeight(32)),
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(vertical: 14),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(50),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withValues(alpha: 0.1),
                    //         spreadRadius: 3,
                    //         blurRadius: 4,
                    //         offset: const Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Image.asset(AssetUtils.google,
                    //           width: 30, height: 30),
                    //       const SizedBox(width: 8),
                    //       Text('Log In with Google',
                    //           style: context.textTheme.headlineSmall),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 24),
                    // const Row(
                    //   children: [
                    //     Expanded(child: Divider()),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 8),
                    //       child: Text('Or'),
                    //     ),
                    //     Expanded(child: Divider()),
                    //   ],
                    // ),
                    const SizedBox(height: 24),
                    RoundedTextField(
                      hint: 'Enter your E-mail',
                      icon: Icons.email_outlined,
                      controller: viewModel.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedTextField(
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: viewModel.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
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
                        const Text(
                          'Remember me',
                          style: TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.forgetPasswordScreen);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
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
                      title: 'Log In',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account? '),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.registerPage);
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
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
