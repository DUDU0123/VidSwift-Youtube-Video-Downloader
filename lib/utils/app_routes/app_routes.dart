import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/dashborad/pages/dashboard.dart';
import 'package:youtube_video_downloader/views/home_page/pages/home_page.dart';
import 'package:youtube_video_downloader/views/splash_screen/pages/splash_screen.dart';
import 'package:youtube_video_downloader/views/videos_page/pages/videos_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.splash: (context) => const SplashScreen(),
    RoutesName.dashboard: (context) => const Dashboard(),
    RoutesName.home: (context) => const HomePage(),
    RoutesName.videoPage: (context) => const VideosPage(),
  };
}