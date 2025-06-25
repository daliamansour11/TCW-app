import 'package:bloc/bloc.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository_impl.dart';

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
      emit(AuthError(response.errorMessage ?? 'Login failed'));
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    emit(AuthLoading());
    final response = await authRepository.register(data);
    if (response.isSuccess && response.data != null) {
      emit(AuthRegistered(response.data!));
    } else {
      emit(AuthError(response.errorMessage ?? 'Registration failed'));
    }
  }

  Future<void> logout(String token) async {
    emit(AuthLoading());
    final response = await authRepository.logout(token);
    if (response.isSuccess) {
      emit(AuthLoggedOut());
    } else {
      emit(AuthError(response.errorMessage ?? 'Logout failed'));
    }
  }

  Future<ApiResponse> forgetPassword(String email) async {
    return authRepository.forgetPassword(email);
  }

  Future<void> verifyToken(String email, String token) async {
    emit(AuthLoading());
    final response = await authRepository.verifyToken(email, token);
    if (response.isSuccess) {
      emit(AuthTokenVerified(response.data?.toString() ?? 'Token verified'));
    } else {
      emit(AuthError(response.errorMessage ?? 'Invalid token'));
    }
  }

  Future<void> resetPassword(Map<String, dynamic> data) async {
    emit(AuthLoading());
    final response = await authRepository.resetPassword(data);
    if (response.isSuccess) {
      emit(AuthPasswordResetSuccess(
          response.data?.toString() ?? 'Password updated'));
    } else {
      emit(AuthError(response.errorMessage ?? 'Reset failed'));
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
