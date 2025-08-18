import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:http/http.dart' as http;
class ReelAddVideoWidget extends StatelessWidget {
  const ReelAddVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: Colors.white,
      borderRadius: 20,
      boxShadow: AppColors.cardShadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          const SizedBox.shrink(),
           Icon(Icons.video_call, size: 50, color: Colors.grey),
          CustomText(
            'reel.Add_the_Video_here'.tr(),
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
           CustomText(
               'reel.Click_to_add_video'.tr(),
            color: AppColors.hintTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}


class ReelsAddVideoWidget extends StatefulWidget {
  const ReelsAddVideoWidget({super.key});

  @override
  State<ReelsAddVideoWidget> createState() => _ReelAddVideoWidgetState();
}

class _ReelAddVideoWidgetState extends State<ReelsAddVideoWidget> {
  File? _videoFile;
  final picker = ImagePicker();
  bool isUploading = false;

  Future<void> _recordVideoFromCamera() async {
    final picked = await picker.pickVideo(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _videoFile = File(picked.path);
      });
      _uploadVideo(File(picked.path));
    }
  }

  Future<void> _uploadVideo(File file) async {
    setState(() {
      isUploading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://YOUR_API_URL_HERE/api/reels'),
      );

      request.files.add(await http.MultipartFile.fromPath('video', file.path));

      request.headers.addAll({
        'Authorization': 'Bearer YOUR_TOKEN',
        'Accept': 'application/json',
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        debugPrint('✅ Video uploaded successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uploaded successfully')),
        );
      } else {
        debugPrint('❌ Upload failed with status ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.statusCode}')),
        );
      }
    } catch (e) {
      debugPrint('❌ Upload error: $e');
    }

    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: Colors.white,
      borderRadius: 20,
      boxShadow: AppColors.cardShadow,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _recordVideoFromCamera,
              child: isUploading
                  ? const CircularProgressIndicator()
                  : Icon(
                _videoFile != null ? Icons.check_circle : Icons.videocam,
                size: 50,
                color: _videoFile != null ? Colors.green : Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            CustomText(
              _videoFile != null
                  ? 'Video Recorded & Ready'
                  : 'Add the Video here',
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            const SizedBox(height: 4),
            const CustomText(
              'Tap the video icon to record and upload',
              color: AppColors.hintTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
    // onPressed: () async {
    //   File? pickedVideo = await pickVideo(); // ickVideo بنفسك
    //   if (pickedVideo != null) {
    //     await _uploadVideoWithDio(pickedVideo, context);
    //   }
    // }
  }
}
