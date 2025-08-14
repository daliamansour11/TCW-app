import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/bot_button_widget.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_list_screen.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'your_programs'.tr(),
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.propHeight(12)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchFilterWidget(
                    onChanged: (value) {
                      context.read<StudentCourseCubit>().fetchEnrolledCourses(search: value);
                    },
                  ),
                ),
                SizedBox(height: context.propHeight(12)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BlocBuilder<StudentCourseCubit, StudentCourseState>(
                      builder: (context, state) {
                        if (state is StudentCourseLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is EnrolledCoursesLoaded) {
                          if (state.courses.isEmpty) {
                            return Center(child: Text('no_program_found'.tr()));
                          }
                          return CourseListScreen(courses: state.courses);
                        } else if (state is StudentCourseError) {
                          return Center(child: Text('${'error'.tr()}: ${state.message}'));
                        } else {
                          return Center(child: Text('something_wrong'.tr()));
                        }
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
