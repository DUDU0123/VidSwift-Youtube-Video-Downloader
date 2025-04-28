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
      List<Map<String, String>> uniqueQualities = [];
      homePageController.videoModel?.videoQualityListWithUrl
          ?.forEach((videoQuality) {
        if (!uniqueQualities
            .any((item) => item["quality"] == videoQuality["quality"])) {
          uniqueQualities.add(videoQuality);
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
              icon: Icon(Icons.arrow_drop_down_rounded, color: AppColors.kBlack,size: 30.sp,),
              value: homePageController.selectedQuality.isNotEmpty
                    ? homePageController.selectedQuality
                    : null,
              isExpanded: true,
              items: uniqueQualities.map(
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
                    selectedValue: newValue!);
              },
            ),
          ),
        ),
      );
    });
  }
}
