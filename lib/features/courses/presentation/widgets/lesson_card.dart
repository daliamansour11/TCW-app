import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';
import 'package:zap_sizer/zap_sizer.dart';

class LessonCard extends StatelessWidget {
  // ignore: use_super_parameters
  const LessonCard({Key? key, required this.courseId, required this.section}) : super(key: key);
  final SectionModel section;
  final int  courseId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          AppRoutes.lessonScreen,
        );
      },
      child: CustomContainer(
        width: 80.w,
        color: Colors.white,
        borderRadius: 20,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImage(
                  section.lessons.first.video?.url ?? '',
                  height: 20.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  radius: 20,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: context.propWidth(12),
                right: context.propWidth(12),
                top: context.propHeight(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lap and duration row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5EEDC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Text(
                          section.topic,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                       Row(
                        children: [
                       const    Icon(Icons.access_time,
                              size: 16, color: Colors.black54),
                      const    SizedBox(width: 4),
                          // TODO
                          Text('${section.durationMinutes??13}h',
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.propHeight(8)),
                  Text(
                 section.lessons.first.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: context.propHeight(8)),
                  LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: Colors.grey.shade300,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: context.propHeight(12)),
                   Row(
                    children: [
                     // TODO
                    const  CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(AssetUtils.personAvater),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            section.instructor?.name ??'Coach',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Coach',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return AssetUtils.programPlaceHolder;

    final videoId = uri.queryParameters['v'] ??
        (uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null);

    if (videoId == null) return AssetUtils.programPlaceHolder;

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
  Widget _buildLessonWidget(LessonModel lesson, int index ,BuildContext context) {
    final videoUrl = lesson.video?.linkPath ?? '';
    final thumbnailUrl = getYoutubeThumbnail(videoUrl);

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      // margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InkWell(
          // onTap:()=> Zap.toNamed(
          //     AppRoutes.lessonScreen,
          //     arguments: lesson
          // ),
          // child:
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    height: 140, width:double.infinity, fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(AssetUtils.programPlaceHolder),
                    errorWidget: (context, url, error) =>const Icon(Icons.error), imageUrl:thumbnailUrl,

                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child:Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color: AppColors.greyWhiteColor
                      ),
                      child: IconButton(onPressed: (){
                      }, icon:const Icon(Icons.favorite_border, color: Colors.white),
                      ),
                    )
                ),

              ],
            ),
          ),
          // ),
          const SizedBox(height: 8),

          // Label + Time
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  'Lesson ${index + 1}',
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:  CustomText('${lesson.durationMinutes??'1:30 m'}', fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Title
          CustomText(
            lesson.title ?? '',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Progress
          LinearProgressIndicator(
            value: 0.4,
            backgroundColor: Colors.grey[300],
            color: AppColors.primaryColor,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );

  }

}
