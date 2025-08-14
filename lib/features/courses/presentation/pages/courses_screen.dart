import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/shared/shared_widget/search_filter_widget.dart';
import '../cubit/course/courses_cubit.dart';
import '../widgets/course_item_widget.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>()..fetchCourses();
    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'programs'.tr()), // localized
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchFilterWidget(
              onChanged: (value) {
                context.read<CourseCubit>().fetchCourses(search: value);
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<CourseCubit, CourseState>(
              builder: (context, state) {
                if (state is CourseLoading) {
                  if (_isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('error_message'.tr()), // localized
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              context.read<CourseCubit>()..fetchCourses();
                              Timer(const Duration(seconds: 12), () {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              });
                            },
                            child: Text('retry'.tr()), // localized
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is CoursesLoaded || state is CourseLoadingMore) {
                  final courses = (state is CoursesLoaded)
                      ? state.courses
                      : context.read<CourseCubit>().allCourses;
                  if (courses.isEmpty) {
                    return Center(child: Text('no_courses_found'.tr())); // localized
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return CourseItemWidget(program: course);
                    },
                  );
                } else if (state is CourseError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
