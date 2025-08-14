import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:zapx/zapx.dart';

class VerticalCourseCard extends StatelessWidget {
  const VerticalCourseCard({super.key, required this.course});
  final EnrolledCourseModel course;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
    DateFormat('d/M/yyyy').format(course.date ?? DateTime.now());

    return GestureDetector(
      onTap: () {
        Zap.toNamed(
          AppRoutes.courseDetailsScreen,
          arguments: course,
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Instructor + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: course.thumb != null
                              ? NetworkImage(course.thumb)
                              : null,
                          backgroundColor: Colors.grey[200],
                        ),
                        SizedBox(width: context.propWidth(8)),
                         CustomText(course.instructor??''),
                      ],
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Title
                CustomText(
                  course.title ?? '',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,),


                const SizedBox(height: 8),

                /// Watched progress + Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${course.watchedLessons}/${course.totalLessons} Watched',
                      style: const TextStyle(
                        color: Color(0xFF175941),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 28,
                      child: CustomButton(
                        width: 22.w,
                        height: 28,
                        title: 'SHOW LESSONS',
                        backgroundColor:  Colors.white,
                        textColor:  Colors.black,
                        onPressed: () {
                          Zap.toNamed(
                            AppRoutes.programSubscribeRoundsWidget,
                            arguments:course.id,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: context.propHeight(25)),
        ],
      ),
    );
  }
}
