import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';

class UserInfoSection extends StatelessWidget {

  const UserInfoSection({super.key, required this.reel});
  final Datum reel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(bottom: 8,top: 8,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: CachedNetworkImageProvider(
                  reel.user?.image ??AssetUtils.personAvater,

                ),
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 8),
              Text(
                reel.user?.name ?? '',
                style:const  TextStyle(fontSize: 18,color: Colors.white,
                  fontWeight: FontWeight.w700,),

              ),
              const SizedBox(width: 6),
            ],
          ),

          const SizedBox(height: 8),

          CustomText(
            reel.caption ?? '',

            fontSize: 16,
            maxLines: 2,
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // const   Row(
          //      children: const [
          //        Icon(Icons.music_note, size: 16, color: Colors.white),
          //        SizedBox(width: 4),
          //        CustomText( 'Original Audio',
          //          fontSize: 11,
          //          color: Colors.white,
          //        )
          //      ],
          //    ),
        ],
      ),
    );
  }
}
