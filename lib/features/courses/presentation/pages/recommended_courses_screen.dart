import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';


class RecommendedCoursesScreen extends StatelessWidget {
  const RecommendedCoursesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: context.propHeight(32)),
            const CustomAppBar(
              title: 'Recommended',
            ),
            const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SearchFilterWidget()),
            // TODO
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: ListView.builder(
            //       padding: const EdgeInsets.only(bottom: 80),
            //       itemCount: courses.length,
            //       itemBuilder: (context, index) {
            //         return CourseCard(course: courses[index]);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
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
