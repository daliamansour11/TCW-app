import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/courses/data/models/section_model.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../data/models/course_model.dart';
import '../../data/models/last_viewed_model.dart';
import '../cubit/student/student_course_cubit.dart';

class LessonCard extends StatefulWidget {
  const LessonCard({
    Key? key,
    required this.courseId,
    required this.section,
    required this.lessonModel,
    required this.isWishlisted,
    this.onWishlistToggle,
  }) : super(key: key);

  final SectionModel section;
  final int courseId;
  final LessonModel lessonModel;
  final bool isWishlisted;
  final VoidCallback? onWishlistToggle;

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  late bool isWishlisted;

  @override
  void initState() {
    super.initState();
    isWishlisted = widget.isWishlisted;
    _fetchLastViewed();
    _updateLastViewed();
  }

  Future<void> _fetchLastViewed() async {
    try {
      await context.read<StudentCourseCubit>().getLastViewed();
    } catch (e) {
      debugPrint('Failed to get updated view: $e');
    }
  }

  void _updateLastViewed() {
    context.read<StudentCourseCubit>().updateLastViewed(
      widget.lessonModel.courseId ?? 0,
      widget.lessonModel.sectionId ?? 0,
      widget.lessonModel.id ?? 0,
    );
  }

  String _getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return AssetUtils.programPlaceHolder;

    final videoId = uri.queryParameters['v'] ??
        (uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null);

    return videoId != null
        ? 'https://img.youtube.com/vi/$videoId/0.jpg'
        : AssetUtils.programPlaceHolder;
  }

  Future<void> _toggleWishlist() async {
    final oldValue = isWishlisted;
    setState(() {
      isWishlisted = !isWishlisted;
    });

    final response = await context
        .read<StudentCourseCubit>()
        .toggleLessonWishlist(widget.lessonModel.id ?? 0);

    if (response == null || response.isError) {
      setState(() => isWishlisted = oldValue);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('failed_update_favorite'))),
      );
    } else {
      widget.onWishlistToggle?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = _getYoutubeThumbnail(
      widget.lessonModel.video?.linkPath ?? '',
    );

    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        AppRoutes.lessonScreen,
        arguments: widget.lessonModel,
      ),
      child: CustomContainer(
        width: 80.w,
        color: Colors.white,
        borderRadius: 20,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                  thumbnail,
                  height: 20.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  radius: 20,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: IconButton(
                      onPressed: _toggleWishlist,
                      icon: Icon(
                        isWishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.propWidth(12),
                vertical: context.propHeight(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(),
                  SizedBox(height: context.propHeight(8)),
                  Text(
                    widget.section.lessons.first.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: context.propHeight(8)),
                  LinearProgressIndicator(
                    value: 4.5,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primaryColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SizedBox(height: context.propHeight(12)),
                  _buildInstructorInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EEDC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.section.topic,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: Colors.black54),
            const SizedBox(width: 4),
            Text(
              '${widget.section.durationMinutes ?? 13}h',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructorInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(AssetUtils.personAvater),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.section.instructor?.name ?? tr('coach'),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              tr('coach'),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
