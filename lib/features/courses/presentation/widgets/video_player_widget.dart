import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../data/local_data_source/local_storage.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/presentation/widgets/full_screen_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.videoId,
    required this.sourceType,
  });

  final String videoUrl;
  final String videoId;
  final String sourceType;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with WidgetsBindingObserver {
  VideoPlayerController? _mp4Controller;
  YoutubePlayerController? _ytController;
  final ContinueWatchingManager _continueWatchingManager = ContinueWatchingManager();

  bool _isYoutube = false;
  bool _isPlaying = true;
  bool _isMuted = false;

  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isYoutube = widget.videoUrl.contains('youtu');
    _initVideo();
  }

  Future<void> _initVideo() async {
    if (_isYoutube) {
      await _initYoutube();
    } else {
      // await _initMp4();
    }
  }

  Future<void> _initYoutube() async {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    // final lastPosition = await _continueWatchingManager.getLastPosition(widget.videoUrl);

    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        // startAt: lastPosition,
        controlsVisibleAtStart: false,
      ),
    );

    _ytController!.addListener(_checkYoutubeProgress);
    _startProgressTimer();
    setState(() {});
  }

  // Future<void> _initMp4() async {
  //   _mp4Controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
  //   await _mp4Controller!.initialize();
  //
  //   // final lastPositionSeconds = await _continueWatchingManager.getLastPosition(widget.videoUrl);
  //   if (lastPositionSeconds > 0 && lastPositionSeconds < _mp4Controller!.value.duration.inSeconds) {
  //     await _mp4Controller!.seekTo(Duration(seconds: lastPositionSeconds));
  //   }
  //
  //   _mp4Controller!.setLooping(false);
  //   _mp4Controller!.addListener(_checkMp4Progress);
  //
  //   _startProgressTimer();
  //   setState(() {});
  //   _mp4Controller!.play();
  // }

  void _startProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      // _saveProgress();
    });
  }

  void _checkMp4Progress() {
    if (_mp4Controller!.value.position >= _mp4Controller!.value.duration) {
      // _removeFromContinueWatching();
    }
    if (_mp4Controller!.value.isPlaying != _isPlaying) {
      setState(() => _isPlaying = _mp4Controller!.value.isPlaying);
    }
  }

  void _checkYoutubeProgress() {
    final position = _ytController!.value.position;
    final duration = _ytController!.metadata.duration;

    if (position >= duration) {
      // _removeFromContinueWatching();
    }
  }

  // void _saveProgress() {
  //     if (_isYoutube && _ytController != null) {
  //       final position = _ytController!.value.position.inSeconds;
  //       _continueWatchingManager.saveOrUpdateVideoPosition(
  //         videoUrl: widget.videoUrl,
  //         positionSeconds: position,
  //       );
  //     } else if (_mp4Controller != null && _mp4Controller!.value.isInitialized) {
  //       final position = _mp4Controller!.value.position.inSeconds;
  //       _continueWatchingManager.saveOrUpdateVideoPosition(
  //         videoUrl: widget.videoUrl,
  //         positionSeconds: position,
  //       );
  //     }
  //   }



  // Future<void> _removeFromContinueWatching() async {
  //   await _continueWatchingManager.removeVideo(widget.videoUrl);
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mp4Controller?.dispose();
    _ytController?.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // _saveProgress();
      if (_mp4Controller?.value.isPlaying ?? false) _mp4Controller!.pause();
      _ytController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.propHeight(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: _isYoutube ? _buildYoutubePlayer() : _buildVideoPlayer(),
    );
  }

  Widget _buildYoutubePlayer() {
    if (_ytController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: YoutubePlayer(
        controller: _ytController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primaryColor,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_mp4Controller == null || !_mp4Controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(_mp4Controller!),

          if (!_isPlaying)
            Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow, size: 48, color: Colors.white),
                onPressed: () {
                  _mp4Controller!.play();
                  setState(() => _isPlaying = true);
                },
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
            onPressed: () {
              if (_isPlaying) {
                _mp4Controller!.pause();
              } else {
                _mp4Controller!.play();
              }
              setState(() => _isPlaying = !_isPlaying);
            },
          ),
          IconButton(
            icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
            onPressed: () {
              setState(() {
                _isMuted = !_isMuted;
                _mp4Controller!.setVolume(_isMuted ? 0 : 1);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.fullscreen, color: Colors.white),
            onPressed: _openFullscreen,
          ),
        ],
      ),
    );
  }

  void _openFullscreen() async {
    if (_mp4Controller == null) return;

    final wasPlaying = _mp4Controller!.value.isPlaying;
    if (wasPlaying) _mp4Controller!.pause();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenPlayer(controller: _mp4Controller!),
      ),
    );

    if (wasPlaying) _mp4Controller!.play();
    setState(() => _isPlaying = wasPlaying);
  }
}
