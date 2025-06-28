import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/profile/data/repositories/profile_repository_impl.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final ProfileRepository repository = ProfileRepositoryImpl();

  Future<void> getMyProfile() async {
    emit(ProfileLoading());
    try {
      final response = await repository.getMyProfile();
      if (response.isSuccess) {
        emit(GetProfileLoaded(user: response.data!));
      } else {
        emit(ProfileError());
      }
    } catch (e) {
      emit(ProfileError());
    }
  }

  Future<ProfileState> updateMyProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? imagePath,
    String? password,
    String? confirmPassword,
  }) async {
    emit(ProfileLoading());
    try {
      final response = await repository.updateMyProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        imagePath: imagePath,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (response.isSuccess) {
        emit(GetProfileLoaded(user: response.data!));
      } else {
        emit(ProfileError());
      }
    } catch (e) {
      emit(ProfileError());
    }
    return state;
  }

  Future<void> updateFirebaseToken(String token) async {
    emit(ProfileLoading());
    try {
      await repository.updateFirebaseToken(token);
    } catch (e) {
      emit(ProfileError());
    }
  }

  Future<bool> deleteMyProfile() async {
    emit(ProfileLoading());
    try {
      final response = await repository.deleteMyProfile();
      return response.isSuccess;
    } catch (e) {
      emit(ProfileError());
      return false;
    }
  }
}
