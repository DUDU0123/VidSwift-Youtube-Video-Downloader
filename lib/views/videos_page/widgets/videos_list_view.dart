import 'package:youtube_video_downloader/components/common_button_container.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideosListView extends StatelessWidget {
  const VideosListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemBuilder: (context, index) {
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
                  child: Image.network(
                    "https://picsum.photos/200/300",
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppConstraints.kHeight10,
              Text(
                "Video Title Todays movie malayalam Mohanlal Thudarum",
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
                  
                },
              ), ],
          ),
        );
      },
      itemCount: 10,
    );
  }
}