import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';
import 'package:easy_localization/easy_localization.dart';

class ProgramSubscribeRoundsWidget extends StatelessWidget {
  const ProgramSubscribeRoundsWidget(this.detail, {super.key});

  final ProgramDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final sections = detail.data?.sections ?? [];
    final allLessons = sections
        .expand((section) => section.lessons ?? [])
        .toList();
    return CustomContainer(
      child: allLessons.isEmpty
          ? Center(child: Text(tr('no_lessons_available')))
          : ListView.separated(
        itemCount: allLessons.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final lesson = allLessons[index];

          return GestureDetector(
            onTap: () => Zap.toNamed(
              AppRoutes.lessonScreen,
              arguments: lesson,
                // 'instructorName': detail.data?.instructor?.name ?? 'Unknown Instructor',
            ),
            child:CustomContainer(
              child: allLessons.isEmpty
                  ? Center(child: Text(tr('no_lessons_available')))
                  : ListView.separated(
                itemCount: allLessons.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final lesson = allLessons[index];

                  return GestureDetector(
                    onTap: () => Zap.toNamed(
                      AppRoutes.lessonScreen,
                      arguments: lesson,
                    ),
                    child: CustomContainer(
                      margin: const EdgeInsets.all(10),
                      padding: 8,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: CustomImage(
                                    detail.data?.thumbUrl ??
                                        AssetUtils.programPlaceHolder,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              CustomContainer(
                                padding: 4,
                                borderRadius: 8,
                                color: AppColors.primaryColor.withOpacity(0.3),
                                child: CustomText(
                                  '${tr('lesson_label')} ${lesson.id ?? ''}',
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.access_time, size: 16),
                              CustomText(
                                '${lesson.durationMinutes ?? 10} ${tr('minutes_label')}',
                                fontSize: 14,
                              ),
                            ],
                          ),
                          CustomText(
                            lesson.title ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          LinearProgressIndicator(
                            value: 0.4, // lesson.progress ?? 0.0
                            backgroundColor: Colors.grey[300],
                            color: AppColors.primaryColor,
                            minHeight: 5,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.pending_actions_outlined,
                                size: 16,
                                color: AppColors.primaryColor,
                              ),
                              CustomText(
                                tr('task_pending'),
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
            )

          );
        },
      ),
    );
  }
}
