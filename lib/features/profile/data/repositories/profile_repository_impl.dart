import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/storage/secure_storage_service.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/profile/data/datasources/profile_datasources_impl.dart';

abstract class ProfileRepository {
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
  Future<ApiResponse<void>> deleteMyProfile();
}

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasources datasources = ProfileDatasourcesImpl();
  @override
  Future<ApiResponse<void>> deleteMyProfile() {
    return datasources.deleteMyProfile();
  }

  @override
  Future<ApiResponse<UserModel>> getMyProfile() async {
    final response = await datasources.getMyProfile();
    try {
      if (response.isSuccess) {
        final user = response.data!;
        userData = userData!.copyWith(
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone,
          imagePath: user.image,
          email: user.email,
          address: user.address,
          type: user.type,
          status: user.status,
          identityType: user.identityType,
          identityNumber: user.identityNumber,
          identityProof: user.identityProof,
          deviceToken: user.deviceToken,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          webFcmToken: user.webFcmToken,
          image: user.image,
          name: user.name,
          emailVerifiedAt: user.emailVerifiedAt,
          id: user.id,
        );
        SecureStorageService.instance
            .set(StorageKey.userData, userData!.toJson());
        return response;
      } else {
        return response.error<UserModel>();
      }
    } catch (e) {
      return response.error<UserModel>();
    }
  }

  @override
  Future<ApiResponse<void>> updateFirebaseToken(String token) {
    return datasources.updateFirebaseToken(token);
  }

  @override
  Future<ApiResponse<UserModel>> updateMyProfile(
      {String? firstName,
      String? lastName,
      String? phone,
      String? imagePath,
      String? password,
      String? confirmPassword}) async {
    final response = await datasources.updateMyProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        imagePath: imagePath,
        password: password,
        confirmPassword: confirmPassword);
    try {
      if (response.isSuccess) {
        final user = response.data!;
        userData = userData!.copyWith(
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone,
          imagePath: user.image,
          email: user.email,
          address: user.address,
          type: user.type,
          status: user.status,
          identityType: user.identityType,
          identityNumber: user.identityNumber,
          identityProof: user.identityProof,
          deviceToken: user.deviceToken,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          webFcmToken: user.webFcmToken,
          image: user.image,
          name: user.name,
          emailVerifiedAt: user.emailVerifiedAt,
          id: user.id,
        );
        SecureStorageService.instance
            .set(StorageKey.userData, userData!.toJson());
        return response;
      } else {
        return response.error<UserModel>();
      }
    } catch (e) {
      return response.error<UserModel>();
    }
  }
}
