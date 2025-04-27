import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoTitleDurationAndButton extends StatelessWidget {
  const VideoTitleDurationAndButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Video title"),
        Slider(
          value: 1,
          onChanged: (value) {},
        ),
      const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("00:00"),
             Text("00:00"),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
          ),
      ],
    );
  }
}