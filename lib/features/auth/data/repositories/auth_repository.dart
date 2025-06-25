import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<ApiResponse<UserModel?>> login(String email, String password,bool rememberMe);
  Future<ApiResponse<UserModel?>> register(Map<String, dynamic> data);
  Future<ApiResponse<bool>> logout(String token);
  Future<ApiResponse<bool>> forgetPassword(String email);
  Future<ApiResponse<bool>> verifyToken(String email, String token);
  Future<ApiResponse<bool>> resetPassword(Map<String, dynamic> data);
}