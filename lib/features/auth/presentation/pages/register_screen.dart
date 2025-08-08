

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

    super.dispose();
  }
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingUtil.show();
        } else if (state is AuthRegistered) {
          LoadingUtil.close();
          ToastUtil.show('Welcome ${state.user.name}');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Zap.offAllNamed(
              AppRoutes.homeLayout,);
          });
        } else if (state is AuthError) {
          LoadingUtil.close();
          ToastUtil.show(state.message, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Register',

            style: context.textTheme.headlineMedium),
            automaticallyImplyLeading:false
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
                      hint: 'Enter your Name',
                      icon: Icons.email_outlined,
                      controller: viewModel.firstNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        }

                    ),
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
                    const SizedBox(height: 24),
                    RoundedTextField(
                      hint: 'Please enter your Phone',
                      icon: Icons.phone,
                      // isPassword: true,
                      controller: viewModel.phoneController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone is required';
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 24),


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
                    const SizedBox(height: 24),
                   RoundedTextField(
                      hint: ' Retype Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: viewModel.confirmPasswordController,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please confirm your password';
                         }
                         if (value != viewModel.passwordController.text) {
                           return 'Passwords do not match';
                         }
                         return null;
                       }

                   ),
                    SizedBox(height: context.propHeight(160)),
                    CustomButton(
                      height: context.propHeight(50),
                      onPressed: viewModel.register,
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: context.propWidth(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ), title: 'Register',
                    )  ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text( 'Have an account? '),
                        TextButton(
                          onPressed: () {
                            Zap.toNamed(AppRoutes.loginPage);
                          },
                          child: const Text(
                            ' Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}