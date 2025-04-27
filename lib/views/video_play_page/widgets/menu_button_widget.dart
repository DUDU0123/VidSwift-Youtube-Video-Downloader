import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColors.kBlackDarkShade,
      iconColor: AppColors.kWhite,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: menuItemTextWidget(
              menuName: "Delete",
            ),
          ),
        ];
      },
    );
  }

  Widget menuItemTextWidget({required String menuName}) {
    return Text(
      menuName,
      style: TextStyle(
        fontFamily: AppFonts.poppins,
        color: AppColors.kWhite,
      ),
    );
  }
}
