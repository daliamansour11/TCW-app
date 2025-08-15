import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/bot_button_widget.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_list_screen.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Your Programs',
            style: context.textTheme.headlineMedium,
          )),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.propHeight(12)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchFilterWidget(),
                ),

                SizedBox(height: context.propHeight(12)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child :  BlocBuilder<StudentCourseCubit, StudentCourseState>(
                      builder: (context, state) {
                        if (state is StudentCourseLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is EnrolledCoursesLoaded) {
                          if (state.courses.isEmpty) {
                            return const Center(child: Text('No Program found.'));
                          }
                          return CourseListScreen(courses: state.courses);
                        } else if (state is StudentCourseError) {
                          return Center(child: Text('Error: ${state.message}'));
                        } else {
                          return const Center(child: Text('Some Thing Wrong.'));
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
