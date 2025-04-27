import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoPlayerPlayPauseButton extends StatelessWidget {
  const VideoPlayerPlayPauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayPageController>(
        builder: (videoPlayPageController) {
      return IconButton(
        onPressed: () {
          videoPlayPageController.playPauseVideo();
        },
        icon: Icon(
          videoPlayPageController.isPlaying
              ? Icons.pause
              : Icons.play_arrow_rounded,
          color: AppColors.kWhite,
          size: 36.sp,
        ),
      );
    });
  }
}
