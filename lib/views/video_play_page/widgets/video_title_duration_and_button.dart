import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
class VideoTitleDurationAndButton extends StatelessWidget {
  const VideoTitleDurationAndButton({super.key, required this.video});
  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayPageController>(
      builder: (controller) {
        final current = controller.currentPosition.inSeconds.toDouble();
        final total = controller.totalDuration.inSeconds.toDouble();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              video.videoTitle??"No Title",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
            Slider(
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              value: current > total ? 0 : current,
              min: 0,
              max: total > 0 ? total : 1,
              onChanged: (value) {
                controller.seekTo(Duration(seconds: value.toInt()));
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatDuration(controller.currentPosition),
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                  Text(
                    controller.formatDuration(controller.totalDuration),
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                controller.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
              onPressed: controller.playPauseVideo,
            ),
          ],
        );
      },
    );
  }
}

