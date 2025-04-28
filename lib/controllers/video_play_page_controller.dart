import 'package:video_player/video_player.dart';
import 'package:youtube_video_downloader/repositories/video_repository/video_repository.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoPlayPageController extends GetxController {
  late VideoPlayerController controller;
  VideoRepository videoRepository = VideoRepository();
  bool isPlaying = false;

  void playPauseVideo() {
    if (controller.value.isPlaying) {
      isPlaying = false;
      controller.pause();
    } else {
      isPlaying = true;
      controller.play();
    }
    update();
  }

  Future<void> deleteVideo({required String filePath}) async {
    try {
      String value = await videoRepository.deleteVideo(filePath: filePath);
      if (value.isNotEmpty) {
        debugPrint("Video deleted error: $value");
        AppMessageDialogs.commonSnackbar(
          context: AppGlobalKeys.navigatorKey.currentContext!,
          message: value,
        );
      } else {
        AppMessageDialogs.commonSnackbar(
          context: AppGlobalKeys.navigatorKey.currentContext!,
          message: "Unable to delete video",
        );
      }
    } catch (e) {
      debugPrint("Video delete error: ${e.toString()}");
      AppMessageDialogs.commonSnackbar(
        context: AppGlobalKeys.navigatorKey.currentContext!,
        message: "Unable to delete video",
      );
    }
  }
}
