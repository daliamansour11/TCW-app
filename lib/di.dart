import 'package:get_it/get_it.dart';
import 'package:tcw/features/profile/data/repositories/profile_repository_impl.dart';

final di = GetIt.instance;

void init() {
  di.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
}