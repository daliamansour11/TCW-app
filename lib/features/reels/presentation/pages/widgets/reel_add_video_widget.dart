import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';

class ReelAddVideoWidget extends StatefulWidget {

  const ReelAddVideoWidget({
    super.key,
    required this.onVideoSelected,
    this.selectedVideo,
  });
  final Function(File) onVideoSelected;
  final File? selectedVideo;

  @override
  State<ReelAddVideoWidget> createState() => _ReelAddVideoWidgetState();
}

class _ReelAddVideoWidgetState extends State<ReelAddVideoWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        final File videoFile = File(video.path);
        widget.onVideoSelected(videoFile);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick video: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickVideo,
      child: CustomContainer(
        width: double.infinity,
        color: Colors.white,
        borderRadius: 20,
        boxShadow: AppColors.cardShadow,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
            if (widget.selectedVideo != null) ...[
        Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.selectedVideo != null?
              Container(
                color: Colors.black.withOpacity(0.7),
                child: const Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Colors.white,
                ),
              ):const SizedBox.shrink(),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ],
      Icon(
      widget.selectedVideo != null
      ? Icons.video_library
          : Icons.video_call,
      size: 50,
      color: widget.selectedVideo != null
      ? Colors.green
        : Colors.grey,
      ),
      CustomText(
        widget.selectedVideo != null
            ? 'Video Selected'
            : 'Add the Video here',
        color: AppColors.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
      CustomText(
        widget.selectedVideo != null
            ? 'Tap to change video'
            : 'Click to add a video',
        color: AppColors.hintTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      const SizedBox.shrink(),
      ],
    ),
    ),
    );
  }
}