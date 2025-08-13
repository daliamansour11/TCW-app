import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/lesson_card.dart';

import '../../data/models/lesson_model.dart';
import '../../data/models/section_model.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<LessonModel> favoriteLessons = [];

  @override
  void initState() {
    super.initState();
  }

  void toggleWishlist(LessonModel lesson) {
    setState(() {
      if (favoriteLessons.any((l) => l.id == lesson.id)) {
        favoriteLessons.removeWhere((l) => l.id == lesson.id);
      } else {
        favoriteLessons.add(lesson);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Wish List'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteLessons.isEmpty
            ? Center(child: Text('No favorite lessons yet.'))
            : ListView.builder(
          itemCount: favoriteLessons.length,
          itemBuilder: (context, index) {
            final lesson = favoriteLessons[index];

            final dummySection = SectionModel(
              id: lesson.sectionId ?? 0,
              topic: lesson.title??''    ,
              lessons: [lesson], description:lesson.description??'' ,    courseId:lesson.courseId??0, totalLessons:0, instructor: null,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: LessonCard(
                courseId: lesson.courseId ?? 0,
                section: dummySection,
                lessonModel: lesson,
                onWishlistToggle: () => toggleWishlist(lesson),
                isWishlisted: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

