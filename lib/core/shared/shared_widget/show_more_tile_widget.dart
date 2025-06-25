import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/theme/app_colors.dart';

class ShowMoreTileWidget extends StatelessWidget {
  const ShowMoreTileWidget({
    super.key,
     this.title,
    this.seeAllText = 'See All',
    this.onTab,
  });
  final String? title;
  final VoidCallback? onTab;
  final String seeAllText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(title!=null)
        Text(
          title!,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTab,
          child: Text(
            seeAllText,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
