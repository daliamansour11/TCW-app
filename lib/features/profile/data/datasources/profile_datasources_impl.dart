import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

abstract class ProfileDatasources {
  Future<ApiResponse<UserModel>> getMyProfile();
  Future<ApiResponse<UserModel>> updateMyProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? imagePath,
    String? password,
    String? confirmPassword,
  });
  Future<ApiResponse<void>> updateFirebaseToken(String token);
  Future<ApiResponse<void>> deleteMyProfile(); //TODO
}

class ProfileDatasourcesImpl extends ProfileDatasources {
  @override
  Future<ApiResponse<void>> deleteMyProfile() async {
    final response =
        await ApiService.instance.delete(ApiUrl.profile.deleteMyAccount);
    try {
      if (response.isSuccess) {
        return response.copyWith<void>();
      } else {
        return response.error<void>();
      }
    } catch (e) {
      return response.error<void>();
    }
  }

  @override
  Future<ApiResponse<UserModel>> getMyProfile() async {
    final response = await ApiService.instance.get(ApiUrl.profile.getProfile);
    try {
      if (response.isSuccess) {
        return response.copyWith<UserModel>(
          data: UserModel.fromJson(
            response.data['data'],
          ),
        );
      } else {
        return response.error<UserModel>();
      }
    } catch (e) {
      return response.error<UserModel>();
    }
  }

  @override
  Future<ApiResponse<void>> updateFirebaseToken(String token) async {
    final response = await ApiService.instance.post(
      ApiUrl.profile.updateFirebaseToken,
      data: {
        'device_token': token,
      },
    );
    try {
      if (response.isSuccess) {
        return response.copyWith<void>();
      } else {
        return response.error<void>();
      }
    } catch (e) {
      return response.error<void>();
    }
  }

  @override
  Future<ApiResponse<UserModel>> updateMyProfile(
      {String? firstName,
      String? lastName,
      String? phone,
      String? imagePath,
      String? password,
      String? confirmPassword}) async {
    final formData = FormData();
    if (firstName != null) {
      formData.fields.add(MapEntry('first_name', firstName));
    }
    if (lastName != null) formData.fields.add(MapEntry('last_name', lastName));
    if (phone != null) formData.fields.add(MapEntry('phone', phone));
    if (imagePath != null) {
      final fileBytes = await File(imagePath).readAsBytes();
      final fileName = imagePath.split('/').last;
      formData.files.add(
        MapEntry(
          'image',
          MultipartFile.fromBytes(
            fileBytes,
            filename: fileName,
          ),
        ),
      );
    }
    if (password != null) formData.fields.add(MapEntry('password', password));
    if (confirmPassword != null) {
      formData.fields.add(MapEntry('confirm_password', confirmPassword));
    }

    formData.fields.add(const MapEntry('_method', 'PUT'));
    formData.fields.add(MapEntry('email', userData!.email));
    final response = await ApiService.instance.post(
      ApiUrl.profile.updateProfile,
      data: formData,
    );
    try {
      if (response.isSuccess) {
        return response.copyWith<UserModel>(
          data: UserModel.fromJson(
            response.data['data'],
          ),
        );
      } else {
        return response.error<UserModel>();
      }
    } catch (e) {
      return response.error<UserModel>();
    }
  }
}
