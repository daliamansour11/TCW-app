import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({
    super.key,
    required this.reels,
    this.showFirstIfAvailable = false,
  });
  final List<ReelModel> reels;
  final bool showFirstIfAvailable;

  @override
  Widget build(BuildContext context) {
    if (showFirstIfAvailable) {
      return SizedBox(
        height: 50.h,
        child: Column(
          children: [
            buildReelsTile(context),
            Flexible(
              child: buildReelsList(),
            )
          ],
        ),
      );
    }
    return Scaffold(
      appBar: const CustomAppBar(title: 'TCW Media'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 5,
          children: [
            buildReelsTile(context),
            Expanded(
              child: buildReelsList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildReelsTile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TCW Reels',
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        OutlinedButton.icon(
          onPressed: ()=>Zap.toNamed(AppRoutes.createReelPage),
          icon: const ImageIcon(
            AssetImage(AssetUtils.createReelIcon),
            color: Colors.black,
            size: 18,
          ),
          label: Text('Create a Reel',
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ),
      ],
    );
  }

  Widget buildReelsList() {
    return ListView.builder(
      shrinkWrap: showFirstIfAvailable,
      physics:
          showFirstIfAvailable ? const NeverScrollableScrollPhysics() : null,
      itemCount: showFirstIfAvailable && reels.isNotEmpty ? 1 : reels.length,
      itemBuilder: (context, index) {
        final reel = reels[index];
        return GestureDetector(
          onTap: () => Zap.toNamed(
            AppRoutes.reelViewScreen,
            arguments: reel,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.propWidth(8),
              vertical: 10,
            ),
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(reel.thumbnail),
                fit: BoxFit.fill,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 12, bottom: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  const Icon(Icons.play_arrow, size: 16, color: Colors.black),
                  CustomText(
                    '${reel.views}',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
