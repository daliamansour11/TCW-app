import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';

class ReelSelectOptionsWidget extends StatelessWidget {
  const ReelSelectOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tileItem(
          icon: Icons.group_outlined,
          title: 'Friends',
        ),
        const Divider(),
        tileItem(
          icon: Icons.alternate_email,
          title: 'Mention',
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
