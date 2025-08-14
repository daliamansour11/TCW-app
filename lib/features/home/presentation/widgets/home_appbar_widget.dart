import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' show AppBar, AssetImage, BoxConstraints, BoxDecoration, BoxShape, BuildContext, Center, Colors, Container, Directionality, EdgeInsets, FontWeight, Icon, IconButton, Icons, ImageIcon, Positioned, PreferredSizeWidget, Size, SizedBox, Stack, StatelessWidget, Text, TextStyle, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/utils/asset_utils.dart';
import '../../../auth/data/models/user_model.dart';
import '../home_viewmodel.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../notification/presentation/cubit/notification_cubit.dart';
import 'package:zapx/zapx.dart';
import 'package:intl/intl.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (userData == null) return const SizedBox();

    final textDirection = context.locale.languageCode == 'ar'
        ? TextDirection.RTL
        : TextDirection.LTR;

    return AppBar(
      leading: userData != null
          ? userData!.imageWidget.paddingSymmetric(horizontal: 5)
          : const SizedBox(width: 40),
      centerTitle: false,
      title: CustomText(
        tr('welcome', args: [userData?.getFirstName ?? '']) + ' 👋',
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
                      decoration: const BoxDecoration(
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
