import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';

class AiFieldWidget extends StatelessWidget {
  const AiFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xffffffff).withValues(alpha: 0.2);
    return CustomContainer(
      color: color,
      padding: 5,
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            minLines: 4,
            maxLines: 4,
            hintText: 'What do you want to know?',
            backgroundColor: Colors.transparent,
            borderRadius: 24,
            borderColor: Colors.transparent,
            textColor: Colors.white,
          ),
          Row(
            spacing: 5,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: CustomContainer(
                    padding: 5,
                    isCircle: true,
                    border: Border.all(color: Colors.white),
                    child: const Icon(
                      Icons.add,
                      size: 17,
                      color: Colors.white,
                    ),
                  )),
              CustomButton.icon(
                title: 'Search',
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                icon: const Icon(
                  Icons.language,
                  size: 17,
                  color: Colors.white,
                ),
                iconAlignment: IconAlignment.start,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                onPressed: () {},
              ),
              CustomButton.icon(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                title: 'Think',
                icon: const Icon(
                  Icons.lightbulb_outline,
                  size: 17,
                  color: Colors.white,
                ),
                iconAlignment: IconAlignment.start,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const CircleAvatar(
                    backgroundColor: AppColors.darkGreen,
                    child: Icon(
                      Icons.send,
                      size: 17,
                      color: Colors.white,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
