
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/shared_widget/custom_button.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_image.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/shared/shared_widget/riyal_logo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/asset_utils.dart';

import '../../../../core/routes/app_routes.dart';
import '../../data/models/course_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

import '../../../courses/presentation/cubit/course/courses_cubit.dart';
class CourseItemWidget extends StatelessWidget {
  final CourseModel program;

  const CourseItemWidget({required this.program, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) {
        if (current is CoursesLoaded) {
          final prevCourse = (previous is CoursesLoaded)
              ? previous.courses.firstWhere((c) => c.id == program.id, orElse: () => program)
              : program;

          final currentCourse = current.courses.firstWhere((c) => c.id == program.id, orElse: () => program);

          return prevCourse.isWishlisted != currentCourse.isWishlisted;
        }
        return false;
      },
      builder: (context, state) {
        if (state is! CoursesLoaded) return const SizedBox.shrink();

        // الحصول على نسخة الكورس المحدثة من الـ Cubit
        final course = state.courses.firstWhere((c) => c.id == program.id, orElse: () => program);

        final isFavorite = course.isWishlisted ?? false;

        return CustomContainer(
          margin: const EdgeInsets.only(top: 10),
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
                        course.thumbUrl ?? AssetUtils.programPlaceHolder,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          size: 18,
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<CourseCubit>().toggleCourseWishlist(course.id ?? 0);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  CustomText(
                    course.title ?? 'No title',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  const Spacer(),
                  const RiyalLogo(),
                  CustomText(
                    course.price?.toString() ?? '0',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemSection(
                    Icons.book_outlined,
                    '${course.lessonsCount ?? 15} Lessons',
                  ),
                  buildItemSection(
                    Icons.access_time,
                    '${course.totalDurationMinutes ?? 10} h',
                  ),
                  buildItemSection(
                    Icons.chair_outlined,
                    '${course.availableSeats ?? 12} Available',
                  ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 16,
                  child: course.thumbUrl == null
                      ? const Icon(Icons.person)
                      : CustomImage(
                    course.thumbUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                title: CustomText(
                  '${course.instructorName}',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: const CustomText(
                  'Coach',
                  fontSize: 12,
                  color: Colors.grey,
                ),
                trailing: CustomButton(
                  width: 15.w,
                  backgroundColor: Colors.black,
                  title: 'More Details',
                  onPressed: () => Zap.toNamed(
                    AppRoutes.programmeDetails,
                    arguments: course.id,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItemSection(final IconData icon, final String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primaryColor,
        ),
        CustomText(text, fontSize: 14, color: Colors.grey),
      ],
    );
  }
}
