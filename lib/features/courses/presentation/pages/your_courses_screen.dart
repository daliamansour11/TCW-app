import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/bot_button_widget.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Your Courses',
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
                // TODO
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     child: ListView.separated(
                //       separatorBuilder: (context, index) => SizedBox(
                //         height: context.propHeight(12),
                //       ),
                //       padding: const EdgeInsets.only(bottom: 80),
                //       itemCount: courses.length,
                //       itemBuilder: (context, index) {
                //         return VerticalCourseCard(course: courses[index]);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const BotButtonWidget(),
        ],
      ),
    );
  }
}
