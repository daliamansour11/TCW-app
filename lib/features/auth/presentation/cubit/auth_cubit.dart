import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zapx/zapx.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final AuthRepositoryImpl authRepository;

  Future<void> login(String email, String password, bool rememberMe) async {
    emit(AuthLoading());
    final response = await authRepository.login(email, password, rememberMe);
    if (response.isSuccess && response.data != null) {
      userData = response.data;

      emit(AuthLoggedIn(response.data!));
    } else {
      emit(AuthError(response.message ?? 'Login failed'));
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    emit(AuthLoading());
    final response = await authRepository.register(data);
    if (response.isSuccess && response.data != null) {
      emit(AuthRegistered(response.data!));
    } else {
      emit(AuthError(response.message ?? 'Registration failed'));
    }
  }

  Future<void> logout(String token) async {
    emit(AuthLoading());
    final response = await authRepository.logout(token);
    if (response.isSuccess) {
      emit(AuthLoggedOut());
    } else {
      emit(AuthError(response.message ?? 'Logout failed'));
    }
  }

  Future<ApiResponse> forgetPassword(String email) async {
    return authRepository.forgetPassword(email);
  }

  Future<void> verifyToken(String email, String token) async {
    try {
      emit(AuthLoading());
      final response = await authRepository.verifyToken(email, token);
      LoadingUtil.close();
      logger.d(response.toString());
      if (response.isSuccess) {
        ToastUtil.show('Token verified');
        Zap.toNamed(AppRoutes.resetPasswordScreen, arguments: {
          'email': email,
          'otp': token,
        });
      } else {
        ToastUtil.show(response.message ?? 'Invalid token', true);
        emit(AuthError(response.message ?? 'Invalid token'));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> resetPassword(Map<String, dynamic> data) async {
    emit(AuthLoading());
    final response = await authRepository.resetPassword(data);
    if (response.isSuccess) {
      ToastUtil.show('Password updated successfully');
      emit(AuthPasswordResetSuccess(
          response.data?.toString() ?? 'Password updated'));
      Zap.offAllNamed(AppRoutes.loginPage);
    } else {
      emit(AuthError(response.message ?? 'Reset failed'));
    }
  }

  Future<void> getLoggedUser() async {
    emit(AuthLoading());
    final user = await authRepository.getLoggedUser();
    if (user != null) {
      emit(AuthLoggedIn(user));
    } else {
      emit(AuthInitial());
    }
  }
}
