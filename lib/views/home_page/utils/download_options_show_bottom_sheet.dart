import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

Future<dynamic> downloadOptionsShowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.kTransparent,
      context: context,
      builder: (context) {
        return Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kBlackDarkShade,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              AppConstraints.kHeight20,
              Text(
                "Download Options",
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 18.sp,
                  fontFamily: AppFonts.carterOne,
                ),
              ),
              AppConstraints.kHeight20,
              // Add your download options here
            ],
          ),
        );
      },
    );
  }