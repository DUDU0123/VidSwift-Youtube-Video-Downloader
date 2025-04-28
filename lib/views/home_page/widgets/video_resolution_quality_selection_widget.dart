import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoResolutionQualitySelectionWidget extends StatelessWidget {
  const VideoResolutionQualitySelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (homePageController) {
        return Container(
          height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.kGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: homePageController.videoModel?.videoQualityListWithUrl?.entries.first.key,
            isExpanded: true,
            items: homePageController.videoModel?.videoQualityListWithUrl?.keys.map((videoQuality) {
              return DropdownMenuItem<String>(
                value: videoQuality,
                child: Text(
                  videoQuality,
                  style: textStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 14.sp,
                    color: AppColors.kBlackDarkShade,
                  ),
                ),
              );
            },).toList(),
            onChanged: (newValue) {
              // homePageController.updateSelectedQuality(newValue!);
            },
          ),
        ),
                        );
      }
    );
  }
}