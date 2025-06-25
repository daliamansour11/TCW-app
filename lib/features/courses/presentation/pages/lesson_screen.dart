import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/lesson_model.dart';
import 'package:tcw/features/courses/presentation/widgets/video_player_widget.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.lessonModel});
  final LessonModel lessonModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lessonModel.title,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              const Center(
                child: Text(
                  'Ramy Badr • Sun, 9 March 2025',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const VideoPlayerWidget(
                videoUrl:
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              ),
              _buildLessonInfo(context),
              _buildTaskCard(context),
              _buildSectionHeader(context, 'Continue watching'),
              // TODO
              // const CourseListHorizontal(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: const Color(0x33B7924F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Lesson 6',
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 12,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Text(
            'React Hooks Basics',
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'This lesson covers how to apply styles dynamically and conditionally...,This lesson covers how to apply styles dynamically and conditionally...',
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF9E9E9E),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task',
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            width: double.infinity,
            height: 207,
            margin: EdgeInsets.only(top: context.propHeight(12)),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF1F1F5)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Collecting Moodboard from Dribbble.com',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Text(
                      '1 Day Left',
                      style: TextStyle(
                        color: Color(0xFF951111),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.propHeight(10)),
                  child: Text(
                    "Let's return to design thinking. Over time designers have built up their own body of approaches to solving classes of problems.",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {
                      Zap.toNamed(AppRoutes.tasksScreen);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppColors.primaryColor),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'View Details',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.headlineLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x0F080F34),
          blurRadius: 42,
          offset: Offset(0, 14),
        ),
      ],
    );
  }
}
