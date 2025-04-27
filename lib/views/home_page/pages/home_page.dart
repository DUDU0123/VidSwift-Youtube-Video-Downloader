import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}