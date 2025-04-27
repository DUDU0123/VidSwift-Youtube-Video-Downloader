import 'package:flutter/material.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/menu_button_widget.dart';
import 'package:youtube_video_downloader/views/video_play_page/widgets/video_title_duration_and_button.dart';

class VideoPlayPage extends StatelessWidget {
  const VideoPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          MenuButtonWidget(),
          VideoTitleDurationAndButton()
        ],
      ),
    );
  }
}




