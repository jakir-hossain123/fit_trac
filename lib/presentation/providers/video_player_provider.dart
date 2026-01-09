import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;

  Future<void> initializeVideo(String url) async {
    await _controller?.dispose();
    _isInitialized = false;
    notifyListeners();

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await _controller!.initialize();
      _isInitialized = true;
      _controller!.play();

      _controller!.addListener(() {
        notifyListeners();
      });
    } catch (e) {
      debugPrint("Video Init Error: $e");
    }
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
  void togglePlay() {
    if (_controller != null && _controller!.value.isInitialized) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}