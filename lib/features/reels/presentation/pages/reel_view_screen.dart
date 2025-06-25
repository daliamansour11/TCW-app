import 'package:flutter/material.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ReelViewScreen extends StatelessWidget {
  const ReelViewScreen({super.key, required this.reel});
  final ReelModel reel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(reel.thumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 25,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: Zap.back,
            )),
        Positioned(
            bottom: 50,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 35,
              children: [
                buttonWithValue(
                  icon: Icons.favorite_border,
                  value: '11',
                ),
                buttonWithValue(
                  icon: AssetUtils.commentIcon,
                  value: '11',
                ),
                buttonWithValue(
                  icon: AssetUtils.shareIcon,
                  value: '11',
                ),
                buttonWithValue(
                  icon: Icons.more_vert,
                ),
              ],
            )),
        Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: 25,
                    ),
                    Text(
                      'user name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 70.w,
                  ),
                  child: const Text(
                    'Lorem ipsum dolor sit amet consectetur. Sit adipiscing ...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  Widget buttonWithValue({
    // IconData or String imagePath
    required dynamic icon,
    String? value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: 5,
      children: [
        if (icon is IconData)
          Icon(icon, size: 38, color: Colors.white)
        else
          ImageIcon(AssetImage(icon.toString()), size: 38, color: Colors.white),
        if (value != null)
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
      ],
    );
  }
}
