import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.description,
    required this.points,
    this.isNegative = false,
  });
  final String description;
  final String points;
  final bool isNegative;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomText(description, fontSize: 14),
                const Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 14,
                      color: Colors.grey,
                    ),
                    CustomText(
                      'Monday, 4 Mar 2025',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time_filled,
                      size: 14,
                      color: Colors.grey,
                    ),
                    CustomText(
                      '03:30 PM',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomText(
            points,
            color: isNegative ? Colors.red : AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
