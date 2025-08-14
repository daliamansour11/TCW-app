import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class ReelSelectOptionsWidget extends StatelessWidget {
  const ReelSelectOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tileItem(
          icon: Icons.group_outlined,
          title: 'reel.friends'.tr(),
        ),
        const Divider(),
        tileItem(
          icon: Icons.alternate_email,
          title: 'reel.mention'.tr(),
        ),
      ],
    );
  }

  Widget tileItem({
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
      title: CustomText(
        title,
        fontWeight: FontWeight.w700,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
