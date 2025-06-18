
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.context,
    required this.label,
  });

  final BuildContext context;
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(
          label,
          style: context.textTheme.headlineLarge ?.copyWith(
            fontSize: context.propWidth(16),
            
          ),
        ),
      );
}
