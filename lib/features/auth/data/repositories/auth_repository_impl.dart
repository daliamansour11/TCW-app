import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:tcw/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteDatasource, this._authLocalDatasource);
  final AuthRemoteDatasourceImpl _authRemoteDatasource;
  final AuthLocalDatasourceImpl _authLocalDatasource;
  static const _userKey = 'logged_user';
  @override
  Future<ApiResponse<UserModel>> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final response = await _authRemoteDatasource.login(email, password);
    if (response.isSuccess && response.data != null && rememberMe) {
      await _authLocalDatasource.saveLoggedUser(response.data!);
    }
    return response;
  }

  @override
  Future<ApiResponse<UserModel>> register(Map<String, dynamic> data) async {
    final response = await _authRemoteDatasource.register(data);
    if (response.isSuccess && response.data != null) {
      await _authLocalDatasource.saveLoggedUser(response.data!);
    }
    return response;
  }

  @override
  Future<ApiResponse<bool>> logout(String token) async {
    final response = await _authRemoteDatasource.logout(token);
    if (response.isSuccess) {
      await _authLocalDatasource.logout(token);
    }
    return response;
  }

  @override
  Future<ApiResponse<bool>> forgetPassword(String email) {
    return _authRemoteDatasource.forgetPassword(email);
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> verifyToken(String email, String token) async {
    final response = await ApiService.instance.post(
      ApiUrl.auth.verifyToken,
      data: jsonEncode({
        'email': email,
        'token': token,
      }),


    );

    if (response.isError) {
      return response.error();
    }

    return response.copyWith<Map<String, dynamic>>(data: response.mapData);
  }


  @override
  Future<ApiResponse<bool>> resetPassword(Map<String, dynamic> data) {
    return _authRemoteDatasource.resetPassword(data);
  }
@override
  Future<UserModel?> getLoggedUser() {
    return _authLocalDatasource.getLoggedUser();
  }
  @override
  Future<void> saveLoggedUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
}
