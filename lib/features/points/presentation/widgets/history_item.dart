import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';

class HistoryItem extends StatelessWidget {
  final String description;
  final String points;
  final bool isNegative;

  const HistoryItem({
    super.key,
    required this.description,
    required this.points,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: context.textTheme.headlineSmall),
                 SizedBox(height: context.propHeight(8)),
                const Text("Monday, 4 Mar 2025 • 03:30 PM",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: isNegative ? Colors.red : AppColors  .primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
