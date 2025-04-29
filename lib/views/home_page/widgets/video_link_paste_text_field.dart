import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoLinkPasteTextField extends StatefulWidget {
  const VideoLinkPasteTextField({
    super.key,
  });

  @override
  State<VideoLinkPasteTextField> createState() =>
      _VideoLinkPasteTextFieldState();
}

class _VideoLinkPasteTextFieldState extends State<VideoLinkPasteTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  final border = OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.kGrey),
            );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (homePageController) {
        return TextField(
          enabled: !homePageController.isLoading,
          controller: homePageController.ytVideolinkController,
          style: TextStyle(
            color: AppColors.kWhite,
            fontSize: 15.sp,
            fontFamily: AppFonts.poppins,
          ),
          decoration: InputDecoration(
            suffixIcon: IgnorePointer(
              ignoring: homePageController.isLoading,
              child: GestureDetector(
                onTap: () {
                  homePageController.clearField();
                },
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.kGrey,
                ),
              ),
            ),
            hintText: "Paste Youtube Video Link",
            hintStyle: TextStyle(
              color: AppColors.kGrey,
              fontSize: 15.sp,
              fontFamily: AppFonts.carterOne,
            ),
            enabledBorder: border,
            focusedBorder: border,
            border: border,
            disabledBorder: border
          ),
        );
      }
    );
  }
}
