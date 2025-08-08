import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:zapx/zapx.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (userData == null) return const SizedBox();

    return AppBar(
      leading: userData != null
          ? userData!.imageWidget.paddingSymmetric(horizontal: 5)
          : const SizedBox(width: 40),
      centerTitle: false,
      title: CustomText(
        'Welcome, ${userData?.getFirstName} 👋',
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      actions: [
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final count = context.read<NotificationCubit>().unreadCount;

            return Stack(
              children: [
                IconButton(
                  onPressed: () => Zap.toNamed(AppRoutes.notificationScreen),
                  icon: const ImageIcon(
                    AssetImage(AssetUtils.notification),
                    color: Colors.grey,
                  ),
                ),
                if (count > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration:const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: () => HomeViewmodel.scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(
            Icons.menu_outlined,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
