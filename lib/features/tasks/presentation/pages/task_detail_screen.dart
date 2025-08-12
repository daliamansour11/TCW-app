import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:zap_sizer/zap_sizer.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen(this.task, {super.key});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Task Details',
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 3,
                children: [
                  const CustomText(
                    'Created by',
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  CustomText(
                    task.createdBy,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  const Icon(Icons.circle, size: 4, color: Colors.grey),
                  CustomText(
                    task.createdAt,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ],
              ),
              CustomText(
                task.title,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomContainer(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                fullPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomText(
                  task.status,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          CustomText(
            task.description!,
            color: Colors.grey,
            fontSize: 16,
          ),
          const SizedBox(height: 15),
          const CustomText(
            'Requirements',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return Row(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 6, color: Colors.grey),
                  Flexible(
                    child: CustomText(task.requirements![index],
                        color: Colors.grey),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
          const    CustomText(
                'Final Deadline',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
           const   Row(
                spacing: 5,
                children: [
                  Icon(Icons.calendar_month, color: Colors.red),
                  CustomText(
                    'Sun, 9 March 2025',
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ],
              ),
            const  SizedBox.shrink(),
         const     CustomText(
                'Task Answer',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
         const     CustomTextField(
                hintText: 'Write your answer..',
                maxLines: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                 const   Icon(Icons.attach_file, color: Colors.black),
                    CustomButton(
                      title: 'Send now',
                      backgroundColor: Colors.black,
                      width: 40.w,
                      onPressed: () {},
                    
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
