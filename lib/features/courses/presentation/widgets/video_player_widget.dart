import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/presentation/widgets/full_screen_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final int lessonId;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.lessonId,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  VideoPlayerController? _mp4Controller;
  YoutubePlayerController? _ytController;
  bool _isYoutube = false;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _isInitialized = false;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isYoutube = _isYouTubeUrl(widget.videoUrl);
    _initVideo();
  }

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  Future<void> _initVideo() async {
    if (widget.videoUrl.isEmpty) {
      debugPrint("Video URL is empty for lesson: ${widget.lessonId}");
      return;
    }

    if (_isYoutube) {
      await _initYoutube();
    } else {
      await _initMp4();
    }
  }

  Future<void> _initYoutube() async {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId == null || videoId.isEmpty) {
      debugPrint("Invalid YouTube URL: ${widget.videoUrl}");
      return;
    }

    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );

    setState(() {
      _isInitialized = true;
      _isPlaying = true;
    });
  }

  Future<void> _initMp4() async {
    try {
      _mp4Controller = VideoPlayerController.network(widget.videoUrl);

      await _mp4Controller!.initialize();
      _mp4Controller!.addListener(_videoListener);

      setState(() {
        _isInitialized = true;
        _isPlaying = true;
      });

      _mp4Controller!.play();
    } catch (e) {
      debugPrint("Error initializing MP4 player: $e");
    }
  }

  void _videoListener() {
    if (!mounted) return;
    setState(() {
      _isPlaying = _mp4Controller?.value.isPlaying ?? false;
    });
  }

  void _togglePlayPause() {
    if (_isYoutube) {
      if (_isPlaying) {
        _ytController?.pause();
      } else {
        _ytController?.play();
      }
    } else {
      if (_isPlaying) {
        _mp4Controller?.pause();
      } else {
        _mp4Controller?.play();
      }
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  void _toggleMute() {
    final newMuteState = !_isMuted;
    if (_isYoutube) {
      _ytController?.mute();
    } else {
      _mp4Controller?.setVolume(newMuteState ? 0 : 1);
    }
    setState(() => _isMuted = newMuteState);
  }

  void _openFullscreen() {
    if (!_isInitialized) return;

    if (_isYoutube) {
      // YouTube full screen handled natively
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenPlayer(controller: _mp4Controller!),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mp4Controller?.dispose();
    _ytController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return _buildPlaceholder();
    }

    return Container(
      height: context.propHeight(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _isYoutube
            ? _buildYoutubePlayer()
            : _buildMp4Player(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: context.propHeight(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black12,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildYoutubePlayer() {
    return YoutubePlayer(
      controller: _ytController!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.primaryColor,
    );
  }

  Widget _buildMp4Player() {
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayer(_mp4Controller!),

        if (!_isPlaying)
          Center(
            child: IconButton(
              icon: const Icon(Icons.play_arrow, size: 64, color: Colors.white),
              onPressed: _togglePlayPause,
            ),
          ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildControls(),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.black54,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white
            ),
            onPressed: _togglePlayPause,
          ),
          IconButton(
            icon: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white
            ),
            onPressed: _toggleMute,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.fullscreen, color: Colors.white),
            onPressed: _openFullscreen,
          ),
        ],
      ),
    );
  }
}