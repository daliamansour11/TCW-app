

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constansts/context_extensions.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.titleKey, required this.count});

  final String titleKey; // This will be the translation key
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: tr(titleKey), // Localized title
            style: context.textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' (${count.toString()})', // Optional: format number with locale
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.chevron_left),
            Icon(Icons.chevron_right, color: Colors.brown[400]),
          ],
        ),
      ],
    );
  }
}
