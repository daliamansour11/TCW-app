import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';

import '../cubit/course/courses_cubit.dart';

class CourseCard extends StatefulWidget {

  const CourseCard({super.key, required this.course});
  final CourseModel course;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  @override
  void initState() {
  }
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                    height: 180, width:double.infinity, fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(AssetUtils.programPlaceHolder),
                  errorWidget: (context, url, error) =>const Icon(Icons.error), imageUrl: widget.course.thumbUrl.toString(),

                ),
              ),
              Positioned(
                top: 6,

                right: 6,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      size: 18,
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: ()async {
                      await context.read<CourseCubit>().toggleCourseWishlist(
                         widget.course.id??0,
                      );
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${widget.course.title}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${widget.course.price} \$',
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
                    Text('${widget.course.lessonsCount} lessons'),
                    const Spacer(),
                    const Icon(Icons.access_time, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(widget.course.enrolledStudents.toString()),
                    const SizedBox(width: 12),
                    const Icon(Icons.people, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${widget.course.discount}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(widget.course.thumbUrl.toString()).image,
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ahmed'),
                         Text('Coach',
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
