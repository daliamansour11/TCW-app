
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/shared/shared_widget/show_more_tile_widget.dart';
import 'package:tcw/features/courses/presentation/courses_viewmodel.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_vertical_list.dart';
import 'package:tcw/core/routes/app_routes.dart';

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
      viewmodel.scrollController.addListener(viewmodel.studentScrollListener);
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
                        Modular.to.pushNamed(AppRoutes.myLibraryScreen);
                      },
                    ),
                    // TODO
                    // const CourseListHorizontal(),
                    SizedBox(height: context.propHeight(24)),
                    ShowMoreTileWidget(
                      title: 'Recommended Courses',
                      onTab: () {
                        Modular.to
                            .pushNamed(AppRoutes.recommendedCoursesScreen);
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
                // child: ListView.separated(
                //   scrollDirection: Axis.horizontal,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   itemCount: courses.length,
                //   separatorBuilder: (_, __) => const SizedBox(width: 12),
                //   itemBuilder: (context, index) {
                //     return SizedBox(
                //       width: context.propWidth(300),
                //       child: CourseCard(course: courses[index]),
                //     );
                //   },
                // ),
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
