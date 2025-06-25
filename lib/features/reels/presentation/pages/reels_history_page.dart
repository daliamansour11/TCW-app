import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:zap_sizer/zap_sizer.dart';

List<ReelModel> reels = List.generate(
  4,
  (i) => ReelModel(thumbnail: AssetUtils.reel, views: i + 4),
);

class ReelsHistoryPage extends StatelessWidget {
  const ReelsHistoryPage({
    super.key,
    this.showFirstIfAvailable = false,
  });
  final bool showFirstIfAvailable;
  @override
  Widget build(BuildContext context) {
    if (showFirstIfAvailable) {
      return _buildSection(
        'Wednesday',
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels History'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Wednesday'),
          const SizedBox(height: 16),
          _buildSection('9 Dec'),
          const SizedBox(height: 16),
          _buildSection('1 Dec'),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: showFirstIfAvailable ? Colors.grey : null,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 25.h,
          width: 100.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildReelItem(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReelItem() {
    return SizedBox(
      height: 20.h,
      width: 30.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              AssetUtils.reel,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 6,
            left: 6,
            child: CustomContainer(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: 4,
              padding: 2,
              child: const Row(
                spacing: 2,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                  CustomText(
                    '70',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              child: const Icon(Icons.favorite_border,
                  color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
