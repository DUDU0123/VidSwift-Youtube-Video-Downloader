import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class CommonButtonContainer extends StatelessWidget {
  const CommonButtonContainer({
    super.key,
    required this.buttonText,
    this.buttonColor, this.splashColor,
    this.borderColor, this.gradient,
    this.textColor, this.fontSize,
    this.fontWeight, this.onTap,
    this.borderRadius = 50,
    this.padding,
    this.containerWidth,
    this.containerHeight,
    this.fontFamily = AppFonts.poppins,
    this.strokeWidth = 1.0,
    this.textAlign,
    this.trailingWidget,
  });
  final String buttonText;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? borderColor;
  final LinearGradient? gradient;
  final Color? textColor;
  final double? containerWidth;
  final double? containerHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final String? fontFamily;
  final double strokeWidth;
  final TextAlign? textAlign;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: splashColor?? AppColors.kGreen.withOpacity(0.5),
      onTap: onTap,
      child: Container(
        height: containerHeight,
        width: containerWidth,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(borderRadius),
          color: buttonColor,
          border: Border.all(
            color: borderColor ?? AppColors.kAppLightGreen,
            width: strokeWidth,
          ),
          gradient:gradient
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: fontFamily ?? AppFonts.poppins,
                fontSize: fontSize ?? 15.sp,
                fontWeight:fontWeight?? FontWeight.w500,
                color: textColor ?? AppColors.kWhite,
              ),
            ),
            if(trailingWidget!=null)...[
              AppConstraints.kWidth10,
              trailingWidget!,
            ],
          ],
        ),
      ),
    );
  }
}