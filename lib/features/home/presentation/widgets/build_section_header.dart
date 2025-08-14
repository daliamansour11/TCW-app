import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

Widget buildHeader(
    BuildContext context, {
      String titleKey = 'programs', // Localization key
      Widget? trailing,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr(titleKey), // Translates the key
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (trailing != null) trailing,
      ],
    ),
  );
}
