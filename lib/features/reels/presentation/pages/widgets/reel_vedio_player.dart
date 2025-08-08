import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final VoidCallback? onStartedPlaying;

  const ReelVideoPlayer({
    super.key,
    required this.videoUrl,
    this.onStartedPlaying,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;
  bool _hasStarted = false;
  String? _errorMessage;
  Size _videoSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _videoListener() {
    final controller = _videoController;
    if (controller == null || !mounted || !controller.value.isInitialized) return;

    final value = controller.value;

    // Trigger onStartedPlaying once
    if (value.isPlaying && !_hasStarted) {
      _hasStarted = true;
      widget.onStartedPlaying?.call();
    }

    // Update play state if changed
    if (value.isPlaying != _isPlaying) {
      setState(() => _isPlaying = value.isPlaying);
    }

    // Update video size if changed
    if (value.size != _videoSize) {
      setState(() => _videoSize = value.size);
    }
  }


  Future<void> _initializeVideoPlayer() async {
    try {
      debugPrint('Loading video: ${widget.videoUrl}');

      if (!widget.videoUrl.startsWith('http')) {
        throw Exception('Invalid URL: ${widget.videoUrl}');
      }

      final controller = VideoPlayerController.network(
        widget.videoUrl,
        videoPlayerOptions:  VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      )..setLooping(true);

      await controller.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('Initialization timed out'),
      );

      // Critical mounted check
      if (!mounted) {
        controller.dispose();
        return;
      }

      controller.addListener(_videoListener);
      _videoController = controller;

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: true,
          showControls: false,
          allowFullScreen: true,
          allowMuting: true,
          errorBuilder: (context, message) => _buildErrorPlaceholder(message),
        );
        _isVideoInitialized = true;
        _videoSize = controller.value.size;
      });
    } catch (e) {
      debugPrint('Video error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = e is TimeoutException
              ? 'Video took too long to load'
              : e.toString().replaceAll('Exception: ', '');
        });
      }
      _logDiagnostics();
    }
  }

  Future<void> _logDiagnostics() async {
    try {
      final response = await http.head(Uri.parse(widget.videoUrl));
      debugPrint('Video URL diagnostics - Status: ${response.statusCode}');
      debugPrint('Content-Type: ${response.headers['content-type']}');
      debugPrint('Content-Length: ${response.headers['content-length']}');
    } catch (e) {
      debugPrint('Diagnostics failed: $e');
    }
  }

  void _retryInitialization() {
    setState(() {
      _isVideoInitialized = false;
      _errorMessage = null;
    });
    _initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    // Safe access to controller properties
    final bool isPlaying = _videoController?.value.isPlaying ?? false;
    final bool hasValidSize = _videoSize.width > 0 && _videoSize.height > 0;

    if (_isVideoInitialized &&
        _chewieController != null &&
        hasValidSize) {
      final chewieController = _chewieController!;
      return GestureDetector(
        onTap: () {
          final controller = _videoController;
          if (controller != null && controller.value.isInitialized) {
            setState(() {
              controller.value.isPlaying ? controller.pause() : controller.play();
            });
          }
        },

        child: Chewie(controller: chewieController),
      );
    }

    // Show error if any
    else if (_errorMessage != null) {
      return _buildErrorPlaceholder(_errorMessage!);
    }
    // Show loading indicator while initializing
    else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    }
  }

  Widget _buildErrorPlaceholder(String message) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 50),
            const SizedBox(height: 16),
            const Text(
              'Could not load video',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: _retryInitialization,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}