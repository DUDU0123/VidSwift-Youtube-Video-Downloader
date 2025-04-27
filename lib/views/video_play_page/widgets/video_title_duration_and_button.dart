import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/video_player_play_pause_button.dart';

class VideoTitleDurationAndButton extends StatelessWidget {
  const VideoTitleDurationAndButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          "Video title jsjcsjcjsbcjbsbsubcjsbsbucvscusucuscugsucgsucuscgsucgsfcyfsyfcysfcysyfsyfcy ajsdsnjcnasknkasn cjasjcjsncj cjsjc sjcjsncjs jcjsncj cjsjcnjscbdvjdsnjn",
          style: textStyle(fontSize: 16.sp),
        ),
        Slider(
          activeColor: AppColors.kAppLightGreen,
          inactiveColor: AppColors.kGrey,
          value: 0,
          onChanged: (value) {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "00:00",
                style: textStyle(fontSize: 14.sp),
              ),
              Text(
                "00:00",
                style: textStyle(fontSize: 14.sp)
              ),
            ],
          ),
        ),
        const VideoPlayerPlayPauseButton(),
      ],
    );
  }
}
