import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/courses_viewmodel.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/course_card.dart';

class RecommendedCoursesScreen extends StatefulWidget {
  const RecommendedCoursesScreen({
    super.key,
  });


  @override
  State<RecommendedCoursesScreen> createState() => _RecommendedCoursesScreenState();
}

class _RecommendedCoursesScreenState extends State<RecommendedCoursesScreen> {
  late final CoursesViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = CoursesViewmodel(context)..init(recommended: true);
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        SizedBox(height: context.propHeight(32)),
        const CustomAppBar(
          title: 'Recommended',
        ),
         Padding(
            padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child:            SearchFilterWidget(
              onChanged: (value) {
                print("Searching for: $value");
                CoursesViewmodel(context).onSearch(value);
              },
            )),
        // TODO
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<CourseCubit, CourseState>(
                  builder: (context, state) {
                if (state is CourseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CoursesLoaded ||
                    state is CourseLoadingMore) {
                  final courses = (state is CoursesLoaded)
                      ? (state).courses
                      : context.read<CourseCubit>().allCourses;
                  if (courses.isEmpty) {
                    return const Center(child: Text('No courses found.'));
                  }
                return  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: courses[index]);
                    },
                  );
                }
                return const SizedBox();
              })),
        )
      ])),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF4B248B),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(Icons.smart_toy_outlined, color: Colors.white),
      ),
    );
  }
}
