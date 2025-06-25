import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/theme/app_colors.dart';

class StateItem extends StatelessWidget {
  const StateItem({
    super.key,
    required this.context,
    required this.icon,
    required this.count,
    required this.label,
    required this.onTab,
    this.isAside = false,
  });
 final bool? isAside;

  final BuildContext context;
  final String icon;
  final String count;
  final String label;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        GestureDetector(
          onTap: onTab,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: isAside == true ? 10 : 24,
                height: isAside == true ? 10 : 24,
              ),
            ),
          ),
        ),
        Text(count,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
