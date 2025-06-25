import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/setting/presentation/settings_viewmodel.dart';
import 'package:zapx/zapx.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = SettingsViewmodel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _settingTile(
              context: context,
              icon: AssetUtils.personalDetailsIcon,
              label: 'Personal Details',
              onTap: () => Zap.toNamed(AppRoutes.personalDetailsScreen),
            ),
            _settingTile(
              context: context,
              icon: AssetUtils.subscriptionsIcon,
              label: 'TCW Spaces',
              onTap: () => Zap.toNamed(AppRoutes.tCWMediaScreen),
            ),
            _settingTile(
              context: context,
              icon: AssetUtils.heart,
              label: 'Wishlist',
              onTap: () => Zap.toNamed(AppRoutes.wishListScreen),
            ),
            _settingTile(
              context: context,
              icon: AssetUtils.support,
              label: 'Support & Complaints',
              onTap: () => Zap.toNamed(AppRoutes.supportScreen),
            ),
            _settingTile(
              context: context,
              icon: Icons.pause_circle_outline,
              label: 'suspend Account',
              onTap: viewmodel.suspendAccount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required dynamic icon,
    required String label,
    required VoidCallback onTap,
    Widget? trailing,
    Color color = Colors.black,
    Color iconColor = Colors.black,
    required dynamic context,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: icon is IconData
            ? Icon(icon, color: iconColor, size: 24)
            : Image.asset(
                icon,
                width: 24,
                height: 24,
                color: iconColor,
              ),
        title: CustomText(
          label,
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        trailing: trailing,
      ),
    );
  }
}
