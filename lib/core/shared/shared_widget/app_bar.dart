import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double? width;
  const CustomAppBar({
    required this.title,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: width ?? context.propWidth(12)),
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        //back
      ],
    );
  }
}
