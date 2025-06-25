import 'package:tcw/core/storage/secure_storage_service.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

class AuthLocalDatasourceImpl {
  final _storage = SecureStorageService.instance;

  Future<UserModel?> getLoggedUser() async {
    final data = await _storage.get(StorageKey.userData);
    if (data != null) {
      return UserModel.fromJson(Map.from(data));
    }
    return null;
  }

  Future<void> saveLoggedUser(UserModel user) async {
    await _storage.set(StorageKey.userData, user.toJson());
  }

  Future<void> logout(String token) async {
    await _storage.delete(StorageKey.userData);
  }
}
