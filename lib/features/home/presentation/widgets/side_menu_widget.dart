import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tcw/features/profile/presentation/widgets/menu_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/user_header_widget.dart';
import 'package:tcw/core/routes/app_routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

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
                child: const UserHeader()),
              SizedBox(height: context.propHeight(24)),
              _buildStats(context),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('overview',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: Icons.space_dashboard_outlined,
                  onTap: () {
                    Modular.to.popUntil((route) => route.isFirst);
                    Modular.to.pushNamed(AppRoutes.eventScreen);
                  },
                  title: 'Dashboard'),
              MenuItem(
                  icon: AssetUtils.eventIcon,
                  onTap: () {
                    Modular.to.popUntil((route) => route.isFirst);
                    Modular.to.pushNamed(AppRoutes.eventScreen);
                  },
                  title: 'Events'),
              MenuItem(
                  icon: Icons.move_to_inbox_outlined,
                  title: 'Inbox',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.inboxScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.coursesIcon,
                  title: 'Programmes',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.programmesView);
                  }),
              MenuItem(
                  icon: AssetUtils.payMentIcon,
                  title: 'Payments',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.paymentsScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.taskIcon,
                  title: 'Task',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.tasksScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.masterMindIcon,
                  title: 'Master mind',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.groupsScreen);
                  }),
              MenuItem(
                  icon: AssetUtils.tcwIcon,
                  title: 'TCW media',
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.tCWMediaScreen);
                  }),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('Setting',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: AssetUtils.settingIcon,
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.settingsScreen);
                  },
                  title: 'Setting'),
              MenuItem(
                icon: AssetUtils.logOutIcon,
                onTap: () => HomeViewmodel.logOutDialog(context),
                title: 'Log out',
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      StateItem(
          context: context,
          icon: AssetUtils.notification,
          count: '1',
          label: 'Notification',
          onTab: () {
            Modular.to.pushNamed(AppRoutes.notificationScreen);
          }),
      StateItem(
          context: context,
          icon: AssetUtils.point,
          count: '100',
          label: 'Points',
          onTab: () {
            Modular.to.pushNamed(AppRoutes.pointsRewardsScreen);
          }),
      StateItem(
          context: context,
          icon: AssetUtils.rewards,
          count: '2',
          label: 'Rewards',
          onTab: () {
            Modular.to.pushNamed(
              AppRoutes.pointsRewardsScreen,
            );
          }),
    ],
  );
}

// ignore: unused_element
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.orange),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
