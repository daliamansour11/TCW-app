import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({super.key});

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  String selectedFilter = 'All';


  // List<CourseModel> get filteredCourses {
  //   if (selectedFilter == 'All') return allCourses;
  //   return allCourses.where((c) => c.status == selectedFilter).toList();
  // }
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
             const CustomAppBar(title: 'My Library'),
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
            // TODO
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: filteredCourses.length,
            //     itemBuilder: (context, index) {
            //       final course = filteredCourses[index];
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 16.0),
            //         child: LessonCard(course: course),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      
    );
  }
}
