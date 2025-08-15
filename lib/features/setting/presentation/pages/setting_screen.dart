import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('select_language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('arabic'.tr()),
              onTap: () async {
                await _setLanguage(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('english'.tr()),
              onTap: () async {
                await _setLanguage(const Locale('en'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setLanguage(Locale locale) async {
    await context.setLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_locale', locale.languageCode);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'settings'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _settingTile(
              icon: AssetUtils.personalDetailsIcon,
              label: 'personal_details'.tr(),
              onTap: () => Zap.toNamed(AppRoutes.personalDetailsScreen),
            ),
            _settingTile(
              icon: AssetUtils.subscriptionsIcon,
              label: 'tcw_spaces'.tr(),
              onTap: () => Zap.toNamed(AppRoutes.tCWMediaScreen),
            ),
            _settingTile(
              icon: AssetUtils.heart,
              label: 'wishlist'.tr(),
              onTap: () => Zap.toNamed(AppRoutes.wishListScreen),
            ),
            _settingTile(
              icon: AssetUtils.support,
              label: 'support_complaints'.tr(),
              onTap: () => Zap.toNamed(AppRoutes.supportScreen),
            ),
            _settingTile(
              icon: Icons.pause_circle_outline,
              label: 'suspend_account'.tr(),
              onTap: viewmodel.suspendAccount,
            ),
            _settingTile(
              icon: Icons.language,
              label: 'change_language'.tr(),
              onTap: _showLanguageDialog,
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
