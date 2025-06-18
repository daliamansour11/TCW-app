// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/course_card.dart';
import 'package:tcw/features/courses/presentation/widgets/course_list.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_vertical_list.dart';
import 'package:tcw/routes/routes_names.dart';

class CoursesScreen extends StatefulWidget {
  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

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

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.propHeight(32)),
                    const CustomAppBar(title: 'Courses'),
                    SizedBox(height: context.propHeight(24)),
                    _buildSearchAndFilter(),
                    SizedBox(height: context.propHeight(24)),
                    _buildMyCourses(title: 'My Courses'),
                    SizedBox(height: context.propHeight(10)),
                  ],
                ),
              ),
            ),

            /// CourseListScreen
            SliverToBoxAdapter(child: CourseListScreen()),

            /// Library Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.propHeight(24)),
                    _buildMyCourses(
                      title: 'My Library',
                      onTab: () {
                        Modular.to.pushNamed(AppRoutes.myLibraryScreen);
                      },
                    ),
                    CourseListHorizontal(courses: courses), // Keep as is

                    SizedBox(height: context.propHeight(24)),
                    _buildMyCourses(
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

            /// Recommended Course horizontal list
            SliverToBoxAdapter(
              child: SizedBox(
                height: context.propHeight(400),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: courses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.propWidth(300),
                      child: CourseCard(course: courses[index]),
                    );
                  },
                ),
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

  Widget _buildStatItem(String icon, String count, String label,
      {VoidCallback? onTab}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTab,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Center(child: Image.asset(icon, width: 24, height: 24)),
          ),
        ),
        SizedBox(height: context.propHeight(6)),
        Text(count,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your course here....',
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: context.propWidth(12)),
        const Icon(Icons.filter_alt_outlined, size: 30),
      ],
    );
  }

  Widget _buildMyCourses({
    required String title,
    VoidCallback? onTab,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTab,
          child: Text('See All',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}
