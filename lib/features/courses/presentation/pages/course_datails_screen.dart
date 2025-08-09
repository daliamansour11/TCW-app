import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/bot_button_widget.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/lesson_card.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.courseId});

  final int courseId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.propHeight(32)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: context.propWidth(12)),
                    Text(
                      'Understanding Concept of React',
                      style: context.textTheme.headlineLarge?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ramy Badr',
                      style: TextStyle(
                        color: Color(0xFF7B8392),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: const ShapeDecoration(
                        color: Color(0xFFE2E2EA),
                        shape: OvalBorder(),
                      ),
                    ),
                    const Text(
                      'Sun, 9 March 2025',
                      style: TextStyle(
                        color: Color(0xFF7B8392),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.propHeight(12)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchFilterWidget(),
                ),
                SizedBox(height: context.propHeight(24)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BlocBuilder<CourseCubit, CourseState>(
                      builder: (context, state) {
                        if (state is CourseLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is CourseLessonsLoaded || state is CourseLoadingMore) {
                          final lessons = (state is CourseLessonsLoaded)
                              ? state.lesson
                              : context.read<CourseCubit>().courseLessons;
                          if (lessons.isEmpty) {
                            return const Center(child: Text('No lessons found.'));
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.only(bottom: 80),
                            separatorBuilder: (context, index) => SizedBox(height: context.propHeight(12)),
                            itemCount: lessons.length,
                            itemBuilder: (context, index) {
                              return LessonCard(courseId: courseId, section:lessons[index], lessonModel: lessons[index].lessons.first ,);
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const BotButtonWidget(),
        ],
      ),
    );
  }
}
