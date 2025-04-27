import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.height = 200,
    this.width = 200,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Image.asset(
        "assets/vid_swift_logo.png",
        fit: BoxFit.cover,
      ),
    );
  }
}