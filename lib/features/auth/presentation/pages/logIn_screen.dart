import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/Custom_button.dart';
import 'package:tcw/core/shared/shared_widget/rounded_text_filed.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/routes/routes_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );
      Modular.to.pushNamed(AppRoutes.homeLayout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: context.propHeight(32)),
                   Center(
                    child: Text(
                      "Log in Page",
                      style: context.textTheme.headlineMedium,
                    ),
                  ),
                   SizedBox(height: context.propHeight(32)),
                   Container(
                    width: double.infinity,
                    
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      
                      
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetManger.google,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                         Text("Log In with Google",
                          style: context.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("Or",),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  RoundedTextField(
                    hint: "Enter your E-mail",
                    icon: Icons.email_outlined,
                    controller: _emailController,
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
                    hint: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: _passwordController,
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
                        
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text("Remember me",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Modular.to.pushNamed(AppRoutes.forgotPasswordScreen);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.brown,fontSize: 12,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: context.propHeight(160)),
                  CustomButton(
                    height: context.propHeight(50),
                    onPressed: _login,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: context.propWidth(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    title: "Log In",
                    backgroundColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
