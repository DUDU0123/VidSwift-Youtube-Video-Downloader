import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoLinkPasteTextField extends StatelessWidget {
  const VideoLinkPasteTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:
          Get.find<HomePageController>().ytVideolinkController,
      style: TextStyle(
        color: AppColors.kWhite,
        fontSize: 15.sp,
        fontFamily: AppFonts.poppins,
      ),
      decoration: InputDecoration(
        hintText: "Paste Youtube Video Link",
        hintStyle: TextStyle(
          color: AppColors.kGrey,
          fontSize: 16.sp,
          fontFamily: AppFonts.carterOne,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.kAppLightGreen),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.kGrey),
        ),
      ),
    );
  }
}
