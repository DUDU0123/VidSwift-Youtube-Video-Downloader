import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_video_downloader/repositories/video_repository/video_repository.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
class VideoPageController extends GetxController{
  List<VideoModel> videos = [];
  VideoRepository videoRepository = VideoRepository();
  bool isFetchingVideos = false;

  @override
  void onInit() {
    getAllVideo();
    super.onInit();
  }

  Future<void> getAllVideo() async {
    try {
      isFetchingVideos = true;
     videos = await videoRepository.getAllDownloadedVideos();
     isFetchingVideos = false;
     update();
    } catch (e) {
      isFetchingVideos = false;
      update();
      debugPrint("Error occured on fetching videos ${e.toString()}");
      AppMessageDialogs.commonSnackbar(
            context: AppGlobalKeys.navigatorKey.currentContext!,
            message: "Oops! Unable to fetch videos");
    }finally{
      isFetchingVideos = false;
      update();
    }
  }

}