import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
     this.title,
    this.width,
    super.key,
    this.centerTitle,
    this.backgroundColor,
    this.backIconColor,
  });
  final String? title;
  final double? width;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? backIconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back, color:backIconColor?? Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: centerTitle,
      title: title != null ? CustomText(
        title!,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ) : null,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
