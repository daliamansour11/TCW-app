import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/bot_button_widget.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.propHeight(32)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: context.propWidth(12)),
                    Text(
                      'Understanding Concept of React ',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    //back
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ramy Badr',
                      style: TextStyle(
                        color: Color(0xFF7B8392),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFE2E2EA),
                        shape: OvalBorder(),
                      ),
                    ),
                    const Text(
                      'Sun, 9 March 2025',
                      style: TextStyle(
                        color: Color(0xFF7B8392),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.propHeight(12)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchFilterWidget(),
                ),
                SizedBox(height: context.propHeight(12)),
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
                //         return LessonCard(course: courses[index]);
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
