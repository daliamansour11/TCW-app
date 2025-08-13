// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/constansts/context_extensions.dart';
// import '../../../../core/shared/shared_widget/search_filter_widget.dart';
// import '../../../../core/shared/shared_widget/show_more_tile_widget.dart';
// import '../../data/repositories/student_course_repository_impl.dart';
// import '../courses_viewmodel.dart';
// import '../cubit/course/courses_cubit.dart';
// import '../cubit/student/student_course_cubit.dart';
// import '../widgets/course_card.dart';
// import '../widgets/vertical_course_card.dart';
//
// class CoursesScreen extends StatefulWidget {
//   const CoursesScreen({super.key});
//
//   @override
//   State<CoursesScreen> createState() => _CoursesScreenState();
// }
//
// class _CoursesScreenState extends State<CoursesScreen> {
//   late final CoursesViewmodel viewmodel;
//   late final StudentCourseCubit studentCourseCubit;
//   @override
//   void initState() {
//     super.initState();
//     studentCourseCubit = StudentCourseCubit(StudentCourseRepositoryImpl());
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       studentCourseCubit.fetchEnrolledCourses(limit: 10, offset: 1);
//     });
//   }
//
//   @override
//   void dispose() {
//     studentCourseCubit.close();
//     super.dispose();
//   }
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: studentCourseCubit,
//       child: BlocListener<StudentCourseCubit, StudentCourseState>(
//         listener: (context, state) {
//           if (state is StudentCourseError) {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: const Text('Connection Error'),
//                 content: Text(state.message),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       // Retry fetching courses
//                       studentCourseCubit.fetchEnrolledCourses(limit: 10, offset: 1);
//                     },
//                     child: const Text('Try Again'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Courses',
//               style: context.textTheme.headlineMedium,
//             ),
//           ),
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: CustomScrollView(
//               slivers: [
//                 const SliverPadding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   sliver: SliverToBoxAdapter(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: 15,
//                       children: [
//                         SearchFilterWidget(),
//                         ShowMoreTileWidget(title: 'My Courses'),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 BlocBuilder<StudentCourseCubit, StudentCourseState>(
//                   builder: (context, state) {
//                     if (state is StudentCourseLoading) {
//                       return const SliverToBoxAdapter(
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 32),
//                           child: Center(child: CircularProgressIndicator()),
//                         ),
//                       );
//                     } else if (state is EnrolledCoursesLoaded || state is CourseLoadingMore) {
//                       final courses = state is EnrolledCoursesLoaded
//                           ? state.courses
//                           : context.read<StudentCourseCubit>().enrolledCourses;
//
//                       if (courses.isEmpty) {
//                         return const SliverToBoxAdapter(
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 32),
//                             child: Center(child: Text('No courses found.')),
//                           ),
//                         );
//                       }
//
//                       return SliverPadding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         sliver: SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                                 (context, index) {
//                               final course = courses[index];
//                               return VerticalCourseCard(course: course);
//                             },
//                             childCount: courses.length,
//                           ),
//                         ),
//                       );
//                     } else if (state is StudentCourseError) {
//                       return const SliverToBoxAdapter(
//                         child: SizedBox.shrink(), // Already handled by BlocListener
//                       );
//                     }
//                     return const SliverToBoxAdapter(child: SizedBox.shrink());
//                   },
//                 ),
//
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: context.propHeight(400),
//                     child: BlocBuilder<CourseCubit, CourseState>(
//                       builder: (context, state) {
//                         if (state is CourseLoading) {
//                           return const Center(child: CircularProgressIndicator());
//                         } else if (state is CoursesLoaded || state is CourseLoadingMore) {
//                           final courses = (state is CoursesLoaded)
//                               ? (state).courses
//                               : context.read<CourseCubit>().allCourses;
//                           if (courses.isEmpty) {
//                             return const Center(child: Text('No courses found.'));
//                           }
//                           return ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             itemCount: courses.length,
//                             separatorBuilder: (_, __) => const SizedBox(width: 12),
//                             itemBuilder: (context, index) {
//                               return SizedBox(
//                                 width: context.propWidth(300),
//                                 child: CourseCard(course: courses[index]),
//                               );
//                             },
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ),
//                 ),
//
//                 SliverToBoxAdapter(
//                   child: SizedBox(height: context.propHeight(32)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';

import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';

import 'package:tcw/features/programmes/presentation/widgets/programme_item_widget.dart';

import '../cubit/course/courses_cubit.dart';
import '../widgets/course_item_widget.dart';
class CoursesScreen extends StatefulWidget {
  CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {

  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    context.read<ProgramCubit>()..fetchPrograms();
    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Programs'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchFilterWidget(
              onChanged: (value) {
                context.read<ProgramCubit>().fetchPrograms(search: value);
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
                          const Text('Something went wrong or took too long.'),
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
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is CoursesLoaded ||
                    state is CourseLoadingMore) {
                  final courses = (state is CoursesLoaded)
                      ? (state).courses
                      : context.read<CourseCubit>().allCourses;
                  if (courses.isEmpty) {
                    return const Center(child: Text('No courses found.'));
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                   final   course = courses[index];
                      return CourseItemWidget(program: course); // Fixed props
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
