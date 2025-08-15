

import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class SectionHeader extends StatelessWidget {

  const SectionHeader({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: context.textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: ' ($count)', style: const TextStyle(color: Colors.green)),
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

