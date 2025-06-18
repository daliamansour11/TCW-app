import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/presentation/widgets/full_screen_player.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.propHeight(350),
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),
                  _buildControlsOverlay(),
                  _buildProgressBar(),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildControlsOverlay() {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_controller.value.position),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  _formatDuration(_controller.value.duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: () {
                    final newPos = _controller.value.position -
                        const Duration(seconds: 10);
                    _controller.seekTo(
                        newPos > Duration.zero ? newPos : Duration.zero);
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMuted = !_isMuted;
                      _controller.setVolume(_isMuted ? 0 : 1);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.picture_in_picture_alt_rounded,
                      color: Colors.white),
                  onPressed: _openFullscreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openFullscreen() async {
    final wasPlaying = _controller.value.isPlaying;
    if (wasPlaying) _controller.pause();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenPlayer(controller: _controller),
      ),
    );

    if (wasPlaying) _controller.play();
    setState(() {});
  }

  Widget _buildProgressBar() {
    return Positioned(
      bottom: 48,
      left: 0,
      right: 0,
      child: VideoProgressIndicator(
        _controller,
        allowScrubbing: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        colors: VideoProgressColors(
          playedColor: AppColors.primaryColor,
          bufferedColor: Colors.white38,
          backgroundColor: Colors.white24,
        ),
      ),
    );
  }
}
