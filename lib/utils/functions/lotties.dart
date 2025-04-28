import 'package:lottie/lottie.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

Widget loadingLottie() {
  return Lottie.network(
    errorBuilder: (context, error, stackTrace) {
      return const SizedBox.shrink();
    },
    fit: BoxFit.cover,
    "https://lottie.host/1210e27c-040d-47ae-b733-52dd5425cf19/pVzdbsz7QT.json",
  );
}
