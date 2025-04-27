import 'package:video_player/video_player.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
class VideoPlayPageController extends GetxController{
  late VideoPlayerController controller;
  bool isPlaying = false;

  void playPauseVideo(){
    if (controller.value.isPlaying) {
      isPlaying = false;
      controller.pause();
    }else{
      isPlaying = true;
      controller.play();
    }
    update();
  }
}