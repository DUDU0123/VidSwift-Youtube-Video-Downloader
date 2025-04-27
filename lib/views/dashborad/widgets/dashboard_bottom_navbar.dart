import 'package:youtube_video_downloader/controllers/dash_board_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class DashboardBottomNavBar extends StatelessWidget {
  const DashboardBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (dashboardController) {
            return Theme(
    data: Theme.of(context).copyWith(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child: BottomNavigationBar(
      backgroundColor: AppColors.kBlack,
      unselectedFontSize: 10.sp,
      selectedFontSize: 11.sp,
      selectedItemColor: AppColors.kAppLightGreen,
      unselectedItemColor: AppColors.kAppLightGreen.withOpacity(0.5),
      currentIndex: dashboardController.currentBottomNavIndex,
      onTap: (value) {
        dashboardController.updateCurrentBottomNavIndex(index: value);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection_rounded),
          label: 'Videos',
        ),
      ],
    ),
            );
          });
  }
}