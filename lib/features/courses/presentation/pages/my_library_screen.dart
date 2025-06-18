import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/lesson_card.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  String selectedFilter = 'All';

  final List<CourseModel> allCourses = [
    CourseModel(
      title: 'Lesson 2',
      coachName: 'Zeina Ahmed',
      available: 1,
      coachImageUrl: AssetManger.ex_1,
      duration: '2 h : 30 m',
     coachRole: 'Instructor',
     imageUrl: AssetManger.ex_2,
     lessons:  8,
      totalLessons: 8,
      watchedLessons: 6,
      date: DateTime(2025, 2, 25),
      status: 'Watched',
      price: 100.0,
    ),
    CourseModel(
      title: 'Lesson 1',
      coachName: 'Amir Ali',
      available: 1,
      coachImageUrl: AssetManger.ex_2,
      duration: '2 h : 30 m',
     coachRole: 'Instructor',
     imageUrl: AssetManger.ex_1,
     lessons:  8,
      totalLessons: 8,
      watchedLessons: 6,
      date: DateTime(2025, 2, 25),
      status: 'Unfinished',
      price: 100.0,
    ),
  ];

  List<CourseModel> get filteredCourses {
    if (selectedFilter == 'All') return allCourses;
    return allCourses.where((c) => c.status == selectedFilter).toList();
  }
Widget buildTab(String label) {
  final bool isSelected = selectedFilter == label;

  return GestureDetector(
    onTap: () => setState(() => selectedFilter = label),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF2E6D9) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? Colors.transparent : const Color(0xFFE0E0E0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFFB58D4A) : Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
 @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: context.propHeight(32)),
             CustomAppBar(title: 'My Library'),
             SizedBox(height: context.propHeight(24)),
            Wrap(
              spacing: 10,
              children: [
                buildTab('All'),
                buildTab('Watched'),
                buildTab('Unfinished'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: LessonCard(course: course),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
