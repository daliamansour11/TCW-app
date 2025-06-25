import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<ApiResponse<UserModel?>> login(String email, String password);
  Future<ApiResponse<UserModel?>> register(Map<String, dynamic> data);
  Future<ApiResponse<bool>> logout(String token);
  Future<ApiResponse<bool>> forgetPassword(String email);
  Future<ApiResponse<bool>> verifyToken(String email, String token);
  Future<ApiResponse<bool>> resetPassword(Map<String, dynamic> data);
}
