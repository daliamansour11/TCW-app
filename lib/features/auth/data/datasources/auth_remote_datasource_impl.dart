import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/auth/data/datasources/auth_datasources.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceImpl implements AuthDatasource {
  @override
  Future<ApiResponse<UserModel>> login(String email, String password) async {
    final response = await ApiService.instance.post(ApiUrl.auth.login, data: {
      'email': email,
      'password': password,
    });

    if (response.isError) {
      return response.error();
    }
  final map = response.mapData;
      final user = UserModel.fromJson(map['data']);
    user.token = map['token'];
    return response.copyWith<UserModel>(
      data: user,
    );
  }

  @override
  Future<ApiResponse<UserModel>> register(Map<String, dynamic> data) async {
    final response =
        await ApiService.instance.post(ApiUrl.auth.register, data: data);
    if (response.isError) {
      return response.error();
    }
    final json = response.data;
    final user = UserModel.fromJson(json['data']);
    user.token = json['token'];
    return response.copyWith<UserModel>(
      data: user,
    );
  }

  @override
  Future<ApiResponse<bool>> logout(String token) async {
    final response = await ApiService.instance.get(ApiUrl.auth.logout);
    if (response.isError) {
      return response.error();
    }
    return response.copyWith<bool>();
  }

  @override
  Future<ApiResponse<bool>> forgetPassword(String email) async {
    final response =
        await ApiService.instance.post(ApiUrl.auth.forgetPassword, data: {
      'email': email,
    });
    if (response.isError) {
      return response.error();
    }
    return response.copyWith<bool>();
  }

  @override
  Future<ApiResponse<bool>> verifyToken(String email, String token) async {
    final response =
        await ApiService.instance.post(ApiUrl.auth.verifyToken, data: {
      'email': email,
      'token': token,
    });
    if (response.isError) {
      return response.error();
    }
    return response.copyWith<bool>();
  }

  @override
  Future<ApiResponse<bool>> resetPassword(Map<String, dynamic> data) async {
    final response =
        await ApiService.instance.post(ApiUrl.auth.resetPassword, data: data);
    if (response.isError) {
      return response.error();
    }
    return response.copyWith<bool>();
  }
}
