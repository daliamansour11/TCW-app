import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/extensions/cubit_extensions.dart';
import 'package:tcw/core/shared/extensions/text_editing_controller_extensions.dart';
import 'package:tcw/core/storage/secure_storage_service.dart';
import 'package:tcw/core/utils/loading_util.dart';
import 'package:tcw/core/utils/permission_util.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:zapx/zapx.dart';

class ProfileViewmodel {
  ProfileViewmodel(this.context);
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final firstNameController = TextEditingController(text: userData?.firstName);
  final lastNameController = TextEditingController(text: userData?.lastName);
  final phoneController = TextEditingController(text: userData?.phone);
  String? imagePath;

  void dispose() {
    emailController.dispose();
    otpController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    imagePath = null;
    formKey.currentState?.reset();
  }

  Future<void> getMyProfile() async {
    await context.read<ProfileCubit>().getMyProfile();
  }

  Future<void> updateFirebaseToken(String token) async {
    await context.read<ProfileCubit>().updateFirebaseToken(token);
  }

  Future<bool> deleteMyProfile() async {
    final result = await context.read<ProfileCubit>().deleteMyProfile();
    if (result) {
      SecureStorageService.instance.delete(StorageKey.userData);
      userData = null;
      ToastUtil.show('Profile deleted successfully');
      Zap.offAllNamed(AppRoutes.loginPage);
    }
    return result;
  }

  // Personal Details Edit
  void pickImage() async {
    bool isGranted = await PermissionUtil.isImagePermissionGranted();
    if (!isGranted) {
      final result = await PermissionUtil.requestImagePermission();
      if (result.isGranted) {
        isGranted = true;
      } else if (result.isPermanentlyDenied) {
        if (!context.mounted) return;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text('Please allow photo access from app settings.'),
            actions: [
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('Open Settings'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
        return;
      } else {
        ToastUtil.show('Permission denied to access photos.');
        return;
      }
    }

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      if (!context.mounted) return;

      context.read<ProfileCubit>().update(ProfileLoaded());
    }
  }

  // Save Changes
  void saveChanges() async {
    LoadingUtil.show(context);
    final state = await context.read<ProfileCubit>().updateMyProfile(
          firstName: firstNameController.valueOrNull,
          lastName: lastNameController.valueOrNull,
          phone: phoneController.valueOrNull,
          imagePath: imagePath,
          password: passwordController.valueOrNull,
          confirmPassword: confirmPasswordController.valueOrNull,
        );
    LoadingUtil.close();

    if (state is GetProfileLoaded) {
      await ToastUtil.show('Profile updated successfully');

      if (context.mounted) {
        Zap.back(context: context);
      }
    } else {
      ToastUtil.show('Profile update failed', true);
    }
  }
}
