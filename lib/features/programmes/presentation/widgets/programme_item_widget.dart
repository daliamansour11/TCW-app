import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/riyal_logo.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';

import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/programmes/data/models/programme_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ProgrammeItemWidget extends StatefulWidget {
  const ProgrammeItemWidget({required this.program, super.key}); // Fixed props
  final ProgramModel program;
  @override
  State<ProgrammeItemWidget> createState() => _ProgrammeItemWidgetState();
}

class _ProgrammeItemWidgetState extends State<ProgrammeItemWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Use program.program directly if available

    return CustomContainer(
      margin: const EdgeInsets.only(top: 10),
      padding: 5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    height: 180, width:double.infinity, fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(AssetUtils.programPlaceHolder),
                    errorWidget: (context, url, error) =>const Icon(Icons.error,color: Colors.red,),
                    imageUrl: widget.program.thumbUrl.toString(),

                  ),

                ),
              ),
              Positioned(
                top: 6,

                right: 6,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {

                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
          Row(spacing: 5,
            children: [
              CustomText(
                widget.program.title ?? 'No title',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              const RiyalLogo(),
              CustomText(
                widget.program.price?.toString() ?? '0',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildItemSection(
                Icons.book_outlined,
                '${widget.program.lessonsCount ?? 15} Lessons',
              ),
              buildItemSection(
                Icons.access_time,
                '${widget.program.totalDurationMinutes??10} h',
              ),
              buildItemSection(
                Icons.chair_outlined,
                '${widget.program.availableSeats ?? 12} Available',
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 16,
              child: widget.program.thumbUrl == null
                  ? const Icon(Icons.person)
                  : CustomImage(
                widget.program.thumbUrl!,
                fit: BoxFit.cover,
              ),
            ),
            title:  CustomText(
              '${widget.program.instructorName}',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            subtitle: const CustomText(
              'Coach',
              fontSize: 12,
              color: Colors.grey,
            ),
            trailing: CustomButton(
              width: 15.w,
              backgroundColor: Colors.black,
              title: 'More Details',
              onPressed: () => Zap.toNamed(
                AppRoutes.programmeDetails,
                arguments: widget.program.id
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemSection(final IconData icon, final String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primaryColor,
        ),
        CustomText(text, fontSize: 14, color: Colors.grey),
      ],
    );
  }
}