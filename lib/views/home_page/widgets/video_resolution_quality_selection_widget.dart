import 'dart:developer';

import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoResolutionQualitySelectionWidget extends StatelessWidget {
  const VideoResolutionQualitySelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController) {
      
      homePageController.videoModel?.videoQualityListWithUrl
          ?.forEach((videoQuality) {
        if (!homePageController.uniqueVideoQualities
            .any((item) => item["quality"] == videoQuality["quality"])) {
          homePageController.uniqueVideoQualities.add(videoQuality);
        }
      });
      homePageController.videoModel?.audioQualityListWithUrl
          ?.forEach((audioQuality) {
        if (!homePageController.uniqueVideoQualities
            .any((item) => item["quality"] == audioQuality["quality"])) {
          homePageController.uniqueVideoQualities.add(audioQuality);
        }
      });
      return IntrinsicWidth(
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColors.kGreenButtonGradientOne,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.kBlack,
                size: 30.sp,
              ),
              value: homePageController.selectedQuality.isNotEmpty
                  ? homePageController.selectedQuality
                  : null,
              isExpanded: true,
              items: homePageController.uniqueVideoQualities.map(
                (videoQuality) {
                  return DropdownMenuItem<String>(
                    value: videoQuality["quality"],
                    child: Text(
                      videoQuality["quality"] ?? '',
                      style: textStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14.sp,
                        color: AppColors.kBlack,
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (newValue) {
                homePageController.updateSelectedQuality(
                  selectedValue: newValue!,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
