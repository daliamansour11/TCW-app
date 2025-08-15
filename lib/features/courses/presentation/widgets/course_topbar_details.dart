import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

import '../../data/models/course_detail_model.dart';

class CourseTopBarDetails extends StatelessWidget {
  const CourseTopBarDetails(this.detail, {super.key});
  final CourseDetailModel detail;

  String _formatDate(String dateString, BuildContext context) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy', context.locale.languageCode).format(date);
    } catch (e) {
      return tr('invalid_date');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          CustomText(
            detail.data?.instructor?.name ?? tr('unknown'),
            fontSize: 14,
          ),
          splitedIcon(),
          // if (detail.createdAt != null)
          //   CustomText(
          //     _formatDate('${detail.createdAt!}', context),
          //     fontSize: 14,
          //   ),
          const Spacer(),
          splitedIcon(),
          const SizedBox(width: 4),
          if (detail.data?.isSubscribed == false)
            Row(
              children: [
                const Icon(
                  Icons.chair_outlined,
                  size: 16,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 4),
                CustomText(
                  plural('available_seat', detail.data?.availableSeats ?? 0),
                  fontSize: 14,
                ),
              ],
            ),
        ],
      ),

    );
  }

  Widget splitedIcon() => Icon(
    Icons.circle,
    color: Colors.grey.shade200,
    size: 8,
  );
}
