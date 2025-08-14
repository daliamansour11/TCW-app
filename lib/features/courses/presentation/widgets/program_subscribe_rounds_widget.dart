import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

import '../../data/models/course_details_model.dart';
class ProgramSubscribeRoundsWidget extends StatefulWidget {
  const ProgramSubscribeRoundsWidget(this.detail, {super.key});

  final CourseDetailsModel detail;

  @override
  State<ProgramSubscribeRoundsWidget> createState() => _ProgramSubscribeRoundsWidgetState();
}

class _ProgramSubscribeRoundsWidgetState extends State<ProgramSubscribeRoundsWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final sections = widget.detail.data?.sections ?? [];
    final allLessons = sections.expand((section) => section.lessons ?? []).toList();

    return CustomContainer(
      child: allLessons.isEmpty
          ? const Center(child: Text('No lessons available'))
          : ListView.separated(
        itemCount: allLessons.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final lesson = allLessons[index];

          return  GestureDetector(
            onTap: () => Zap.toNamed(
              AppRoutes.lessonScreen,
              arguments: {
                'lesson': lesson,
                'instructorName': widget.detail.data?.instructor?.name ?? 0,
              },
            ),


            child: CustomContainer(
              margin: const EdgeInsets.all(10),
              padding:8,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CustomImage(
                            widget.detail.data?.thumbUrl ?? AssetUtils.programPlaceHolder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,

                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {

                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ),
                      ),                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CustomContainer(
                        padding: 4,
                        borderRadius: 8,
                        color: AppColors.primaryColor.withOpacity(0.3),
                        child: CustomText(
                          'Lesson ${lesson.id ?? ''}',
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.access_time, size: 16),
                      CustomText(
                        '${lesson.durationMinutes ?? 10} min',
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    lesson.title ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.4, //    lesson.progress
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primaryColor,
                    minHeight: 5,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.pending_actions_outlined,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 4),
                      CustomText(
                        'Task Pending',
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}