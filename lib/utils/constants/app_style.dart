import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

TextStyle textStyle({
  required double fontSize,
  String? fontFamily,
  Color? color,
  double? height,
  FontWeight? fontWeight,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color ?? AppColors.kWhite,
    fontFamily: fontFamily ?? AppFonts.poppins,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    overflow: overflow,
  );
}
