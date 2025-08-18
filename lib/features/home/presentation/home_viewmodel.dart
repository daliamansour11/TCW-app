import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/shared/shared_widget/custom_icon_dialog.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../auth/data/models/user_model.dart';
import 'package:zapx/zapx.dart';

class HomeViewmodel {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void logOutDialog(BuildContext context) {
    customIconDialog(
      context,
      title: 'auth.logout_confirmation'.tr(),     icon: const Icon(
        Icons.logout_outlined,
        color: Colors.red,
      ),
      buttons: CustomIconDialogButtons(
        firstTitle: 'Cancel'.tr(),
        secondTitle: 'Log_out'.tr(),
        firstOnPressed: Zap.back,
        secondOnPressed: logOut,
      ),
    );
  }
  // Are You Surce You Want To Log Out?/
  static void logOut() async {
    await SecureStorageService.instance.delete(StorageKey.userData);
    userData = null;
    Zap.offAllNamed(AppRoutes.loginPage);
  }
}
