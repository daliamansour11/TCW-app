import 'package:get_it/get_it.dart';
import 'package:tcw/core/storage/secure_storage_service.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

final di = GetIt.instance;
Future<void> init() async {
  final user = await SecureStorageService.instance.get(StorageKey.userData);
  if (user != null) {
    userData = UserModel.fromJson(Map.from(user));
  }
}
