import 'package:video_player/video_player.dart';
import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/menu_button_widget.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/video_title_duration_and_button.dart';

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key});

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  @override
  void initState() {
    super.initState();
    final videoPlayPageController = Get.find<VideoPlayPageController>();
    videoPlayPageController.controller =
        VideoPlayerController.networkUrl(Uri.parse(""))
          ..initialize().then((_) {}).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<VideoPlayPageController>(
              builder: (videoPlayPageController) {
                if (videoPlayPageController.controller.value.isInitialized) {
                  return AspectRatio(
                    aspectRatio:
                        videoPlayPageController.controller.value.aspectRatio,
                    child: VideoPlayer(
                      videoPlayPageController.controller,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Oops!\nUnable to play video",
                      textAlign: TextAlign.center,
                      style: textStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
            const Positioned(
              right: 10,
              child: MenuButtonWidget(),
            ),
            Positioned(
              bottom: 15.h,
              left: 10,
              right: 10,
              child: const VideoTitleDurationAndButton(),
            )
          ],
        ),
      ),
    );
  }
}
