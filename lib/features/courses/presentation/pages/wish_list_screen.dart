import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/utils/asset_utils.dart';
import '../widgets/lesson_card.dart';
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
    // In a real app, you would load favorites from storage or API
    // _loadFavoriteLessons();
  }

  void toggleWishlist(LessonModel lesson) {
    setState(() {
      if (favoriteLessons.any((l) => l.id == lesson.id)) {
        favoriteLessons.removeWhere((l) => l.id == lesson.id);
      } else {
        favoriteLessons.add(lesson);
      }
    });
    // In a real app, you would save the updated list
    // _saveFavoriteLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'wishlist.title'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteLessons.isEmpty
            ? EmptyStateWidget(
          imagePath: AssetUtils.heart,
          title: 'wishlist.empty_title'.tr(),
          subtitle: 'wishlist.empty_subtitle'.tr(),
          actionText: 'wishlist.browse_courses'.tr(),
          onAction: () => Navigator.pop(context),
        )
            : ListView.builder(
          itemCount: favoriteLessons.length,
          itemBuilder: (context, index) {
            final lesson = favoriteLessons[index];

            final dummySection = SectionModel(
              id: lesson.sectionId ?? 0,
              topic: lesson.title ?? '',
              lessons: [lesson],
              description: lesson.description ?? '',
              courseId: lesson.courseId ?? 0,
              totalLessons: 0,
              instructor: null,
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


class EmptyStateWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback onAction;

  const EmptyStateWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 150),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onAction,
              child: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }
}