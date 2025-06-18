import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/course_vertical_card.dart';
import 'package:tcw/features/home/presentation/widgets/search_widget.dart';

class MyCourseScreen extends StatelessWidget {
  final List<CourseModel> courses = [
    CourseModel(
      title: "Flutter Development",
      imageUrl: AssetManger.ex_1,
      price: 199.99,
      lessons: 20,
      duration: "10 hours",
      available: 1,
      coachName: "John Doe",
      coachRole: "Senior Developer",
      coachImageUrl: AssetManger.ex_2,
    ),
    CourseModel(
      title: "Dart Programming",
      imageUrl: AssetManger.ex_2,
      price: 149.99,
      lessons: 15,
      duration: "8 hours",
      available: 1,
      coachName: "Jane Smith",
      coachRole: "Software Engineer",
      coachImageUrl: AssetManger.ex_1,
    ),
    // Add more courses as needed
  ];

  MyCourseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: context.propHeight(32)),
            CustomAppBar(title: 'Your Courses'),
            
            SizedBox(height: context.propHeight(12)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchWidget(
                context: context,
              ),
            ),
            SizedBox(height: context.propHeight(12)),
           /*  Container(
              width: 335,
              height: 65,
              decoration: ShapeDecoration(
                color: const Color(0xFFF8F8F8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 1094,
                    top: 28,
                    child: Container(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-1.57),
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(),
                    ),
                  ),
                  Positioned(
                    left: 12.91,
                    top: 12,
                    child: Container(
                      width: 138,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 138,
                            child: Text(
                              'Lap 1',
                              style: TextStyle(
                                color: Colors.black /* Color-2 */,
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    Text(
                                      '12 lesson',
                                      style: TextStyle(
                                        color: const Color(0xFF7B8392),
                                        fontSize: 11,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    Text(
                                      '16 h : 30 m',
                                      style: TextStyle(
                                        color: const Color(0xFF7B8392),
                                        fontSize: 11,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    Text(
                                      '15 students',
                                      style: TextStyle(
                                        color: const Color(0xFF7B8392),
                                        fontSize: 11,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            */ SizedBox(height: context.propHeight(12)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: context.propHeight(12),
                  ),
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return VerticalCourseCard(course: courses[index]);
                  },
                ),
              ),
            ),
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
