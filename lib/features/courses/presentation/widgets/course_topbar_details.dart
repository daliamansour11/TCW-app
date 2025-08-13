import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

import '../../data/models/course_details_model.dart';

class CourseTopBarDetails extends StatelessWidget {
  const CourseTopBarDetails(this.detail, {super.key});
  final CourseDetailsModel detail;

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            detail.data?.instructor?.name ?? 'Unknown',
            fontSize: 14,
          )
          ,
          splitedIcon(),
          // CustomText(
          //   detail.createdAt != null
          //       ? _formatDate('${detail.createdAt!}')
          //       : 'No date',
          //   fontSize: 14,
          // ),
          const Spacer(),
          const SizedBox(width: 4),
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
                  '${detail.data?.availableSeats ?? 0}',
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
