import 'package:youtube_video_downloader/controllers/dash_board_controller.dart';
import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/controllers/video_page_controller.dart';
import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
void initControllers(){
  Get.put<DashBoardController>(DashBoardController());
  Get.put<HomePageController>(HomePageController());
  Get.put<VideoPageController>(VideoPageController());
  Get.put<VideoPlayPageController>(VideoPlayPageController());
}