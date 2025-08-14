import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final VoidCallback onWatchedEnough;

  const LessonVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.onWatchedEnough,
  });

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  VideoPlayerController? _controller;
  Timer? _youtubeTimer;
  bool _markedWatched = false;

  @override
  void initState() {
    super.initState();
    if (_isYoutubeUrl(widget.videoUrl)) {
      _startYoutubeTimer();
    } else {
      _initVideoController(widget.videoUrl);
    }
  }

  bool _isYoutubeUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && (uri.host.contains('youtube.com') || uri.host.contains('youtu.be'));
  }

  void _initVideoController(String url) async {
    _controller = VideoPlayerController.network(url);
    await _controller!.initialize();
    _controller!.play();
    _controller!.addListener(_videoListener);
    if (mounted) setState(() {});
  }

  void _videoListener() {
    if (_controller == null) return;
    final seconds = _controller!.value.position.inSeconds;
    if (seconds >= 10 && !_markedWatched) _markWatched();
  }

  void _startYoutubeTimer() {
    int secondsWatched = 0;
    _youtubeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsWatched++;
      if (secondsWatched >= 10 && !_markedWatched) {
        _markWatched();
        timer.cancel();
      }
    });
  }

  void _markWatched() {
    _markedWatched = true;
    widget.onWatchedEnough();
  }

  @override
  void dispose() {
    _youtubeTimer?.cancel();
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }
}
