import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/home_page/widgets/video_resolution_quality_selection_widget.dart';

Future<dynamic> downloadOptionsShowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.kTransparent,
      context: context,
      builder: (context) {
        return GetBuilder<HomePageController>(
          builder: (homePageController) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.kBlackDarkShade,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppConstraints.kHeight20,
                    Text(
                      "Download Options",
                      style: textStyle(
                        fontFamily: AppFonts.carterOne,
                        fontSize: 18.sp,
                      ),
                    ),
                    AppConstraints.kHeight20,
                    Text(
                      homePageController.videoModel?.videoTitle ?? "No title found",
                      style: textStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 18.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Select video quality",
                          style: textStyle(
                            fontFamily: AppFonts.carterOne,
                            fontSize: 18.sp,
                          ),
                        ),
                        AppConstraints.kWidth15,
                        const VideoResolutionQualitySelectionWidget(),
                      ],
                    ),
                    
                    
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }


