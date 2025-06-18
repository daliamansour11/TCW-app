import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/home/presentation/widgets/menu_item_widget.dart';
import 'package:tcw/features/home/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/home/presentation/widgets/user_header_widget.dart';
import 'package:tcw/routes/routes_names.dart';

class SideMenu extends StatelessWidget {
   SideMenu({super.key, });


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.propHeight(20)),
              UserHeader(
                context: context,
                isAside: true,
              ),
              SizedBox(height: context.propHeight(24)),
              _buildStats(context),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text("overview",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: AssetManger.eventIcon,
                  onTap: () {
                   
                    Modular.to.popUntil((route) => route.isFirst);
                    Modular.to.pushNamed(AppRoutes.eventScreen);
                  },
                  title: "Events"),
              MenuItem(icon: AssetManger.inboxIcon, title: "Inbox",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.inboxScreen);
                  }),
           
              MenuItem(icon: AssetManger.coursesIcon, title: "Courses",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.coursesScreen);
                  }),
               MenuItem(icon: AssetManger.taskIcon, title: "Task",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.TasksScreen);
                  }),
               MenuItem(icon: AssetManger.payMentIcon, title: "Payments",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.paymentsScreen);
                  }),
               MenuItem(
                  icon: AssetManger.masterMindIcon, title: "Master mind",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.groupsScreen);
                  }),
                  
              
               MenuItem(icon: AssetManger.tcwIcon, title: "TCW media",
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.tCWMediaScreen);
                  }),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text("Setting",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              MenuItem(
                  icon: AssetManger.settingIcon,
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.settingsScreen);
                  },
                  title: "Setting"),
              const MenuItem(
                icon: AssetManger.logOutIcon,
                title: "Log out",
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
          icon: AssetManger.notification,
          count: '1',
          label: 'Notification',
          onTab: () {
            Modular.to.pushNamed(AppRoutes.notificationScreen);
          }),
      StateItem(
          context: context,
          icon: AssetManger.point,
          count: '100',
          label: 'Points',
          onTab: () {
            Modular.to.pushNamed(
              AppRoutes.pointsRewardsScreen,
            );
          }),
      StateItem(
          context: context,
          icon: AssetManger.rewards,
          count: '2',
          label: 'Rewards',
          onTab: () {
            Modular.to.pushNamed(
              AppRoutes.pointsRewardsScreen,
              arguments: false,
            );
          }),
    ],
  );
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

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
