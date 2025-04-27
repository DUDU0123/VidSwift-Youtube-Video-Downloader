import 'package:youtube_video_downloader/utils/app_routes/app_routes.dart';
import 'package:youtube_video_downloader/utils/app_routes/routes_name.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

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
          initialRoute: RoutesName.splash,
          routes: AppRoutes.routes,
        ),
    );
  }
}