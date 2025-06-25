import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

Future<T?> customIconDialog<T>(
  BuildContext context, {
  required final String title,
  final String? subTitle,
  final Widget? icon,
  final Widget? action,
  final CustomIconDialogButtons? buttons,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: CustomContainer(
        fullPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            icon ??
                const CustomContainer(
                  isCircle: true,
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(23, 89, 65, 1),
                    Color.fromRGBO(183, 164, 79, 1),
                  ]),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
            CustomText(
              title,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            if (subTitle != null)
              CustomText(
                subTitle,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 10),
      actions: buttons != null
          ? [buttons]
          : action != null
              ? [action]
              : null,
    ),
  );
}

class CustomIconDialogButtons extends StatelessWidget {
  const CustomIconDialogButtons(
      {super.key,
      required this.firstTitle,
      this.secondTitle,
      this.firstOnPressed,
      this.secondOnPressed,
      this.firstWidth,
      this.secondWidth});
  final String? firstTitle;
  final String? secondTitle;
  final VoidCallback? firstOnPressed;
  final VoidCallback? secondOnPressed;
  final double? firstWidth,secondWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (firstTitle != null)
        CustomButton(
          width: firstWidth??30.w,
          backgroundColor: Colors.transparent,
          borderColor: Colors.grey,
          title: firstTitle!,
          textColor: Colors.grey,
          onPressed: firstOnPressed ?? () {},
        ),
        if (secondTitle != null)
          CustomButton(
            width: secondWidth ?? 30.w,
            title: secondTitle!,
            onPressed: secondOnPressed ?? () {},
          )
      ],
    );
  }
}
