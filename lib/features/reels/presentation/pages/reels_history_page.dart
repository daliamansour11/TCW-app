import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_history_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/presentation/pages/reel_view_screen.dart';
import 'package:zap_sizer/zap_sizer.dart';

class ReelsHistoryPage extends StatefulWidget {
  const ReelsHistoryPage({super.key, this.showFirstIfAvailable = false});
  final bool showFirstIfAvailable;

  @override
  State<ReelsHistoryPage> createState() => _ReelsHistoryPageState();
}

class _ReelsHistoryPageState extends State<ReelsHistoryPage> {
  Map<String, List<ReelHistoryModel>> _groupedHistory = {};
  final String _baseImageUrl = 'https://your-api-base-url.com'; // ADD YOUR BASE URL HERE

  @override
  void initState() {
    super.initState();
    _loadReelHistory();
  }

  Future<void> _loadReelHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('reel_history') ?? [];

    final parsed = rawList.map((e) {
      final json = jsonDecode(e);
      return ReelHistoryModel.fromJson(json);
    }).toList();

    // Group by day
    final Map<String, List<ReelHistoryModel>> grouped = {};
    for (var reel in parsed) {
      final day = _formatDate(reel.watchedAt);
      if (!grouped.containsKey(day)) {
        grouped[day] = [];
      }
      grouped[day]!.add(reel);
    }

    setState(() {
      _groupedHistory = grouped;
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Today';
    } else if (date.difference(now).inDays == -1) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_monthName(date.month)}';
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  String _getValidVideoUrl(String? url) {
    if (url == null || url.isEmpty) return '';

    if (url.startsWith('http')) return url;

    final base = _baseImageUrl.endsWith('/')
        ? _baseImageUrl
        : '$_baseImageUrl/';

    return '$base${url.replaceFirst('storage/app/public/', '')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_groupedHistory.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CustomText('No watched reels yet.'),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Reels History',),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _groupedHistory.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(entry.key, entry.value),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSection(String title, List<ReelHistoryModel> reels) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: widget.showFirstIfAvailable ? Colors.grey : null,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 25.h,
          width: 100.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: reels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return _buildReelItem(context, reels[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReelItem(BuildContext context, ReelHistoryModel item) {
    // FIX: Use the validated video URL
    final videoUrl = _getValidVideoUrl(item.videoUrl);

    return GestureDetector(
      onTap: videoUrl.isNotEmpty ? () async {
        final updatedReel = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReelViewScreen(
              reel: Datum.fromHistory(item),
              videoUrl: videoUrl,
              user_id: item.user.id ?? 0,
            ),
          ),
        );

        if (updatedReel is Datum) {
          setState(() {
            final updatedItem = item.copyWith(
              isLiked: updatedReel.isLiked,
              likesCount: updatedReel.likesCount,
              commentsCount: updatedReel.commentsCount,
              viewsCount: updatedReel.viewsCount,
            );

            final day = _formatDate(item.watchedAt);
            final index = _groupedHistory[day]!.indexOf(item);
            _groupedHistory[day]![index] = updatedItem;
          });
        }
      } : null, // Disable tap if no valid video URL
      child: SizedBox(
        height: 20.h,
        width: 30.w,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.thumbnailUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => Image.asset(
                  AssetUtils.reel,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: CustomContainer(
                color: Colors.black.withOpacity(0.1),
                borderRadius: 4,
                padding: 2,
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 20),
                    CustomText('${item.viewsCount}', color: Colors.white),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 6,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Icon(
                  item.isLiked == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            // ADD THIS: Show warning icon if video is unavailable
            if (videoUrl.isEmpty)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.amber,
                      size: 30,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}