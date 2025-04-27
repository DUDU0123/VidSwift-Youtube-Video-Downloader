import 'package:youtube_video_downloader/controllers/dash_board_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/dashborad/widgets/dashboard_bottom_navbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashBoardController>(
        builder: (dashboardController) {
          return dashboardController
              .pages[dashboardController.currentBottomNavIndex];
        },
      ),
      bottomNavigationBar: const DashboardBottomNavBar(),
    );
  }
}
