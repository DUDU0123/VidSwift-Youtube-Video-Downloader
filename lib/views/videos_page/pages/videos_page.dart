import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/videos_page/widgets/videos_list_view.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloaded Videos",
          style: TextStyle(
              color: AppColors.kWhite,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.carterOne),
        ),
      ),
      body: const VideosListView(),
    );
  }
}
