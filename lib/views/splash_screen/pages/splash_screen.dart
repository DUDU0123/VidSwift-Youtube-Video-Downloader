import 'package:youtube_video_downloader/utils/app_routes/routes_name.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/splash_screen/widgets/app_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      3.seconds,
      () {
        AppGlobalKeys.navigatorKey.currentState?.pushReplacementNamed(
          RoutesName.dashboard,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLogoWidget(),
      ),
    );
  }
}
