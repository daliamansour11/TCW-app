import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/routes/routes_names.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    //  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.asset(course.imageUrl,
                      height: 180, width:double.infinity, fit: BoxFit.cover),
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${course.price.toInt()} \$',
                      style: const TextStyle(
                          color: Color(0xFF4B248B),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.menu_book, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${course.lessons} lessons'),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time,
                        size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(course.duration),
                    const SizedBox(width: 12),
                    const Icon(Icons.people, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${course.available}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.asset(course.coachImageUrl).image,
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.coachName),
                        const Text('Coach',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                         Modular.to.pushNamed(AppRoutes.courseDetailsScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'More Details',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
