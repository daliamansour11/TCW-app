import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: userData!.imageWidget.paddingSymmetric(horizontal: 5),
      centerTitle: false,
      title: CustomText(
        'Welcome, ${userData!.getFirstName} 👋',
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      actions: [
        IconButton(
          onPressed: () => Zap.toNamed(AppRoutes.notificationScreen),
          icon: const ImageIcon(
            AssetImage(AssetUtils.notification),
            color: Colors.grey,
          ),
        ),
        IconButton(
            onPressed: () => HomeViewmodel.scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.grey,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
