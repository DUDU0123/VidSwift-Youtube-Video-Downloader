import 'dart:developer';

import 'package:youtube_video_downloader/components/common_button_container.dart';
import 'package:youtube_video_downloader/controllers/video_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/utils/functions/lotties.dart';

class VideosListView extends StatefulWidget {
  const VideosListView({
    super.key,
  });

  @override
  State<VideosListView> createState() => _VideosListViewState();
}

class _VideosListViewState extends State<VideosListView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPageController>(builder: (videosPageController) {
      if (videosPageController.isFetchingVideos) {
        return Center(child: loadingLottie(),);
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemBuilder: (context, index) {
          log("Thumbanil : ${videosPageController.videos[index].videoThumbnail?.path}");
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: Column(
              children: [
                Container(
                  width: AppConstraints.kScreenWidth(context: context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: videosPageController.videos[index].videoThumbnail!=null? Image.file(
                      videosPageController.videos[index].videoThumbnail!,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ):Image.asset("assets/images/vid_swift_logo.png"),
                  ),
                ),
                AppConstraints.kHeight10,
                Text(
                  videosPageController.videos[index].videoTitle ??
                      'No Title Available',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kWhite,
                    fontFamily: AppFonts.poppins,
                  ),
                ),
                AppConstraints.kHeight10,
                CommonButtonContainer(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  buttonText: "Play Now",
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.kBlack,
                  buttonColor: AppColors.kAppLightGreen,
                  trailingWidget: Icon(
                    Icons.play_circle_outline_rounded,
                    color: AppColors.kBlack,
                  ),
                  onTap: () {
                    AppGlobalKeys.navigatorKey.currentState?.pushNamed(
                        RoutesName.videoPlayPage,
                        arguments: videosPageController.videos[index]);
                  },
                ),
              ],
            ),
          );
        },
        itemCount: videosPageController.videos.length,
      );
    });
  }
}
