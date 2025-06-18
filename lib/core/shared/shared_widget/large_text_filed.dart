// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_theme.dart';
import 'package:tcw/core/theme/app_colors.dart';

class LargeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;

  const LargeTextField({super.key, required this.controller, this.hint});

  @override
  _LargeTextFieldState createState() => _LargeTextFieldState();
}

class _LargeTextFieldState extends State<LargeTextField> {
  int currentLength = 0;
  final int maxLength = 256;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.propHeight(128),
      decoration: BoxDecoration(
        border: Border.all(
          color:Colors.grey, // Border color
          width: 1, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
        color: Colors.white, // Ensure background is white
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10), // Padding inside the TextField
            child: TextField(
              controller: widget.controller,
              maxLength: maxLength, // Limit to 256 characters
              maxLines: null, // Allow multiline input
              style: TextStyle(
                fontSize: 16, // Match font size to the image
                color:
                    Colors.black, // Ensure text color is black for visibility
              ),
              cursorColor: Colors.black, // Black cursor for visibility
              onChanged: (text) {
                setState(() {
                  currentLength = text.length; // Update character count
                });
              },
              decoration: InputDecoration(
                hintText:
                  widget.  hint ?? 'Enter your text here...', // Default hint text
                hintStyle: AppTheme(context)
                    .theme
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                border: InputBorder.none, // No border inside the text field
                counterText: '', // Remove the default counter (important)
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10, // Position the counter at the bottom-right
            child: Text(
              '$currentLength/$maxLength', // Display character count
              style: TextStyle(
                color: Colors.grey, // Counter text color
                fontSize: 12, // Counter text size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
