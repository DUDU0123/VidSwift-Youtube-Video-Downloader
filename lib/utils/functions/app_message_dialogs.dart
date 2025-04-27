import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class AppMessageDialogs {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonSnackbar({
    required BuildContext context,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.kWhite,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
            fontFamily: AppFonts.carterOne,
          ),
        ),
        backgroundColor: AppColors.kBlackDarkShade,
        duration: 2.seconds,
      ),
    );
  }
}