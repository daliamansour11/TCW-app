

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../courses/data/models/lesson_model.dart' hide LessonModel;
import '../../../courses/presentation/cubit/course/courses_cubit.dart';

class ProgramUnSubscribeExpansionTileWidget extends StatefulWidget {
  const ProgramUnSubscribeExpansionTileWidget(this.detail, {super.key});
  final ProgramDetailModel detail;

  @override
  State<ProgramUnSubscribeExpansionTileWidget> createState() => _ProgramUnSubscribeExpansionTileWidgetState();
}

class _ProgramUnSubscribeExpansionTileWidgetState extends State<ProgramUnSubscribeExpansionTileWidget> {
  String getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return AssetUtils.programPlaceHolder;

    String? videoId;

    if (uri.host.contains('youtu.be')) {
      // رابط قصير: youtu.be/VIDEO_ID
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    } else if (uri.host.contains('youtube.com')) {
      // رابط عادي: youtube.com/watch?v=VIDEO_ID
      videoId = uri.queryParameters['v'];

      // رابط مضمّن: youtube.com/embed/VIDEO_ID
      videoId ??= uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    }

    if (videoId == null || videoId.isEmpty) {
      return AssetUtils.programPlaceHolder;
    }

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  bool isFavorite = false;


  @override
  Widget build(BuildContext context) {
    final sections = widget.detail.data?.sections;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final section = sections![i];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 0),
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              title: CustomText(' ${section.topic}'),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemSection(
                    Icons.book_outlined,
                      plural('lesson', widget.detail.data?.sections?.first.totalLessons ?? 0)
                  ),
                  buildItemSection(
                    Icons.access_time,
                      plural('hours', widget.detail.data?.sections.first.durationMinutes ??12)

                  ),
                  buildItemSection(
                    Icons.people_alt_outlined,
                      plural('available', widget.detail.data?.availableSeats ?? 10)

                  ),
                ],
              ),
              children: [
                SizedBox(
                  height: 30.h,
                  width: 90.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: section.lessons?.length,
                    itemBuilder: (context, index) {
                      return _buildLessonWidget(section.lessons![index], index, context);
                    },
                  ),
                ),
              ],
            ),
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

  Widget _buildLessonWidget(LessonModel lesson, int index ,BuildContext context) {
    final videoUrl = lesson.video?.linkPath ?? '';
    final thumbnailUrl = getYoutubeThumbnail(videoUrl);

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
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
          InkWell(
          onTap:()=> Zap.toNamed(
              AppRoutes.lessonScreen,
              arguments: lesson
          ),
          child:
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
                        context.read<CourseCubit>().toggleCourseWishlist(lesson.id ?? 0);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
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
                  tr('lesson_number', namedArgs: {'number': '${index + 1}'}),
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),

              ),
              const Spacer(),
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomText(
                  plural('duration', lesson.durationMinutes ?? 90, namedArgs: {'count': '${lesson.durationMinutes ?? 90}'}),
                  fontSize: 12,
                ),

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