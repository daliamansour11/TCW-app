import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/features/home/presentation/widgets/build_section_header.dart';
import 'package:tcw/features/home/presentation/widgets/home_appbar_widget.dart';
import 'package:tcw/features/home/presentation/widgets/side_menu_widget.dart';
import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';
import 'package:tcw/features/programmes/presentation/widgets/programme_item_widget.dart';

import 'package:tcw/features/reels/presentation/pages/media_screen.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';

import '../../../courses/presentation/cubit/course/courses_cubit.dart';
import '../../../courses/presentation/widgets/course_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late final ReelsViewmodel reelsViewmodel;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    reelsViewmodel = ReelsViewmodel(context);
    reelsViewmodel.fetchReels();
    Timer(Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    reelsViewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeViewmodel.scaffoldKey,
      appBar: const HomeAppbarWidget(),
      drawer: const SideMenu(),
      body:ListView(
            controller: reelsViewmodel.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const MediaScreen(
                showFirstIfAvailable: true,
                compactHeight: 53,
              ),
      buildHeader(
        context,
        titleKey: 'programs',
        // trailing: TextButton(
        //   onPressed: () {},
        //   child: Text(tr('see_all')),
        // ),
      ),


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
                            Text('something_wrong'.tr()),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<CourseCubit>().fetchCourses();
                                Timer(const Duration(seconds: 12), () {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: Text('retry'.tr()),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is CoursesLoaded || state is CourseLoadingMore) {
                    final courses = (state is CoursesLoaded)
                        ? (state).courses
                        : context.read<CourseCubit>().allCourses;
                    if (courses.isEmpty) {
                      return Center(child: Text('no_courses_found'.tr()));
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
          ));
  }

}
