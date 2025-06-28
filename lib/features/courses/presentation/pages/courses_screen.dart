
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/shared/shared_widget/show_more_tile_widget.dart';
import 'package:tcw/features/courses/presentation/courses_viewmodel.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/course_card.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_vertical_list.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late final CoursesViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = CoursesViewmodel(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewmodel.fetchCourses();
    });
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
          style: context.textTheme.headlineMedium,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    SearchFilterWidget(),
                    ShowMoreTileWidget(title: 'My Courses'),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: CourseListScreen()),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.propHeight(24)),
                    ShowMoreTileWidget(
                      title: 'My Library',
                      onTab: () {
                        Zap.toNamed(AppRoutes.myLibraryScreen);
                      },
                    ),
                    // TODO
                    // const CourseListHorizontal(),
                    SizedBox(height: context.propHeight(24)),
                    ShowMoreTileWidget(
                      title: 'Recommended Courses',
                      onTab: () {
                        Zap.toNamed(AppRoutes.recommendedCoursesScreen);
                      },
                    ),
                    SizedBox(height: context.propHeight(12)),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: context.propHeight(400),
                child:   BlocBuilder<StudentCourseCubit, StudentCourseState>(
            builder: (context, state) {
              if (state is StudentCourseLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CoursesLoaded || state is CourseLoadingMore) {
                final courses = (state is CoursesLoaded)
                    ? (state as CoursesLoaded).courses
                    : context.read<CourseCubit>().allCourses;
                if (courses.isEmpty) {
                  return const Center(child: Text('No courses found.'));
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: courses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.propWidth(300),
                      child: CourseCard(course: courses[index]),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
              ),
            ),

            /// Bottom Padding
            SliverToBoxAdapter(
              child: SizedBox(height: context.propHeight(32)),
            ),
          ],
        ),
      ),
    );
  }

  

}
