import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tcw/features/profile/presentation/widgets/menu_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/user_header_widget.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.propHeight(20)),
              BlocProvider(
                create: (context) => ProfileCubit(),
                child: const UserHeader(),
              ),
              SizedBox(height: context.propHeight(24)),
              _buildStats(context),
              const SizedBox(height: 20),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('overview'.tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: Icons.space_dashboard_outlined,
                  onTap: () {
                    Modular.to.popUntil((route) => route.isFirst);
                    Modular.to.pushNamed(AppRoutes.profilePage);
                  },
                  title: 'dashboard'.tr()),
              MenuItem(
                  icon: AssetUtils.eventIcon,
                  onTap: () {
                    Modular.to.popUntil((route) => route.isFirst);
                    Modular.to.pushNamed(AppRoutes.eventScreen);
                  },
                  title: 'events'.tr()),
              MenuItem(
                  icon: Icons.move_to_inbox_outlined,
                  title: 'inbox'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.inboxScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.coursesIcon,
                  title: 'programmes'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.programmesView);
                  }),
              MenuItem(
                  icon: AssetUtils.payMentIcon,
                  title: 'payments'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.paymentsScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.taskIcon,
                  title: 'task'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.tasksScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.masterMindIcon,
                  title: 'master_mind'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.groupsScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.tcwIcon,
                  title: 'tcw_media'.tr(),
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.tCWMediaScreen);
                  }),
              const SizedBox(height: 20),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('settings'.tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: AssetUtils.settingIcon,
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.settingsScreen);
                  },
                  title: 'setting'.tr()),
              MenuItem(
                icon: AssetUtils.logOutIcon,
                onTap: () => HomeViewmodel.logOutDialog(context),
                title: 'log_out'.tr(),
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStats(BuildContext context) {
  return BlocBuilder<NotificationCubit, NotificationState>(
    builder: (context, state) {
      final unreadCount = BlocProvider.of<NotificationCubit>(context).unreadCount;

      final List<Map<String, dynamic>> statsItems = [
        {
          'label': 'notification'.tr(),
          'icon': AssetUtils.notification,
          'count': '$unreadCount',
          'route': AppRoutes.notificationScreen,
          'args': true,
        },
        {
          'label': 'points'.tr(),
          'icon': AssetUtils.point,
          'count': '100',
          'route': AppRoutes.pointsRewardsScreen,
          'args': true,
        },
        {
          'label': 'rewards'.tr(),
          'icon': AssetUtils.rewards,
          'count': '2',
          'route': AppRoutes.pointsRewardsScreen,
          'args': false,
        },
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: statsItems
            .map(
              (item) => StateItem(
            context: context,
            icon: item['icon'],
            count: item['count'],
            label: item['label'],
            onTab: () => Zap.toNamed(
              item['route'],
              arguments: item['args'],
            ),
          ),
        )
            .toList(),
      );
    },
  );
}
