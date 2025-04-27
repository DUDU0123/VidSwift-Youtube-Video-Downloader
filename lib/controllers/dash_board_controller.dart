import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/home_page/pages/home_page.dart';
import 'package:youtube_video_downloader/views/videos_page/pages/videos_page.dart';
class DashBoardController extends GetxController{
  int currentBottomNavIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const VideosPage(),
  ];
  // method for updating the current bottom navigation index
  void updateCurrentBottomNavIndex({required int index}) {
    currentBottomNavIndex = index;
    update();
  }
}