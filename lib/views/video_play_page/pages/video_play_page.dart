import 'package:better_player_plus/better_player_plus.dart';
import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/utils/functions/lotties.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/video_title_duration_and_button.dart';

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key, required this.video});
  final VideoModel video;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayPageController videoPlayPageController;

  @override
  void initState() {
    super.initState();
    videoPlayPageController = Get.find<VideoPlayPageController>();

    if (widget.video.videoUrl != null && widget.video.videoUrl!.isNotEmpty) {
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.video.videoUrl!,
      );

      videoPlayPageController.betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoDetectFullscreenDeviceOrientation: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: false,
          ),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      videoPlayPageController.setupListeners();
    }
  }

  @override
  void dispose() {
    videoPlayPageController.betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10.h,
              left: 0.w,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
            GetBuilder<VideoPlayPageController>(
              builder: (controller) {
                if (controller.betterPlayerController.isVideoInitialized() ??
                    false) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: controller.betterPlayerController
                          .videoPlayerController!.value.aspectRatio,
                      child: BetterPlayer(
                        controller: controller.betterPlayerController,
                      ),
                    ),
                  );
                } else {
                  // return Center(
                  //   child: Text(
                  //     "Oops!\nUnable to play video",
                  //     textAlign: TextAlign.center,
                  //     style: textStyle(
                  //       fontSize: 20.sp,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // );
                  return Center(
                    child: loadingLottie(),
                  );
                }
              },
            ),

            // Bottom controls
            Positioned(
              bottom: 15.h,
              left: 10,
              right: 10,
              child: VideoTitleDurationAndButton(
                video: widget.video,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
