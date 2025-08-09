import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoListWithThumbnails extends StatelessWidget {
  final List<String> videoUrls;
  final String placeholder;

  const VideoListWithThumbnails({
    super.key,
    required this.videoUrls,
    required this.placeholder,
  });

  String? getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return null;

    String? videoId;

    if (uri.host.contains('youtu.be')) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    } else if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
      videoId ??= uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    }

    if (videoId == null || videoId.isEmpty) return null;

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  Future<Uint8List?> getMp4Thumbnail(String videoUrl) async {
    try {
      return await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 150,
        quality: 75,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: videoUrls.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final url = videoUrls[index];
        final youtubeThumb = getYoutubeThumbnail(url);

        if (youtubeThumb != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              youtubeThumb,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholder(),
            ),
          );
        }

        return FutureBuilder<Uint8List?>(
          future: getMp4Thumbnail(url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  snapshot.data!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return _buildPlaceholder();
            }
          },
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(placeholder),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(child: Icon(Icons.videocam, size: 40)),
    );
  }
}
