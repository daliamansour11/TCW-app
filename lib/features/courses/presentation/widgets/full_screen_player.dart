
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const FullscreenPlayer({super.key, required this.controller});

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  bool _isMuted = false;
  bool _isDragging = false;
  double _dragValue = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    // Continuously rebuild to sync the progress bar
    widget.controller.addListener(() {
      if (!_isDragging && mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final duration = controller.value.duration;
    final position = controller.value.position;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress bar
                  Slider(
                    activeColor: Colors.orange,
                    inactiveColor: Colors.white30,
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    value: _isDragging
                        ? _dragValue
                        : position.inSeconds
                            .clamp(0, duration.inSeconds)
                            .toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _isDragging = true;
                        _dragValue = val;
                      });
                    },
                    onChangeEnd: (val) {
                      setState(() {
                        _isDragging = false;
                        controller.seekTo(Duration(seconds: val.toInt()));
                      });
                    },
                  ),

                  // Time info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(position),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                      Text(_formatDuration(duration),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.replay_10, color: Colors.white),
                        onPressed: () {
                          final pos = controller.value.position -
                              const Duration(seconds: 10);
                          controller.seekTo(
                              pos > Duration.zero ? pos : Duration.zero);
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
                            controller.setVolume(_isMuted ? 0 : 1);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.fullscreen_exit,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
