import 'package:better_player_plus/better_player_plus.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

import 'package:get/get.dart';
import 'dart:async';

class VideoPlayPageController extends GetxController {
  late BetterPlayerController betterPlayerController;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isPlaying = false;

  void setupListeners() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final controller = betterPlayerController.videoPlayerController;
      if (controller != null && controller.value.initialized) {
        currentPosition = controller.value.position;
        totalDuration = controller.value.duration ?? Duration.zero;
        isPlaying = controller.value.isPlaying;
        update();
      }
    });
  }

  void playPauseVideo() {
    final player = betterPlayerController.videoPlayerController;
    if (player != null) {
      if (player.value.isPlaying) {
        betterPlayerController.pause();
      } else {
        betterPlayerController.play();
      }
      isPlaying = !player.value.isPlaying;
      update();
    }
  }

  void seekTo(Duration position) {
    betterPlayerController.seekTo(position);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
