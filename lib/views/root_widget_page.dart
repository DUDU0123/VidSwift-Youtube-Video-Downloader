import 'package:youtube_video_downloader/utils/app_routes/app_routes.dart';
import 'package:youtube_video_downloader/utils/app_routes/routes_name.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/video_play_page/pages/video_play_page.dart';

class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppGlobalKeys.navigatorKey,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.kBlack,
            ),
            scaffoldBackgroundColor: AppColors.kBlack
          ),
          // home: VideoPlayPage(),
          initialRoute: RoutesName.splash,
          routes: AppRoutes.routes,
        ),
    );
  }
}