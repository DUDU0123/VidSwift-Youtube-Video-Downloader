import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_video_downloader/repositories/video_repository/video_repository.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/home_page/utils/download_options_show_bottom_sheet.dart';

class HomePageController extends GetxController {
  TextEditingController ytVideolinkController = TextEditingController();
  VideoRepository videoRepository = VideoRepository();
  VideoModel? videoModel;
  bool isVideoDownloading = false;
  String selectedQuality = '360p';
  String selectedVideoUrl = '';
  String selectedAudioUrl = '';
  bool isLoading = false;
  bool isVideoDownloadCompleted = false;
  List<Map<String, String>> uniqueVideoQualities = [];
  List<Map<String, String>> uniqueAudioQualities = [];
  void pasteLink() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      ytVideolinkController.text = value?.text ?? "";
    });
  }

  void updateIsVideoDownloading({required bool value}) {
    isVideoDownloading = value;
    update();
  }

  void updateSelectedQuality({
    required String selectedValue,
  }) {
    selectedQuality = selectedValue;
    for (var videoQuality in uniqueVideoQualities) {
      if (videoQuality['quality'] == selectedQuality) {
        selectedVideoUrl = videoQuality['url'] ?? '';
      }
    }
    for (var audioQuality in uniqueAudioQualities) {
      if (audioQuality['quality'] == selectedQuality) {
        selectedAudioUrl = audioQuality['url'] ?? '';
      }
    }

    log("Selected URL: ${selectedVideoUrl}");
    update();
  }

  void clearField() {
    if (ytVideolinkController.text.isNotEmpty) {
      ytVideolinkController.text = '';
      update();
    }
  }


  Future<void> getYtVideoDetails({required String videoUrl}) async {
    try {
      videoModel = await videoRepository.fetchYtVideoDetails(videoUrl);
      update();
    } catch (e) {
      if (AppGlobalKeys.navigatorKey.currentContext != null) {
        AppMessageDialogs.commonSnackbar(
            context: AppGlobalKeys.navigatorKey.currentContext!,
            message: "Oops! An unexpected error occured");
      }
      isLoading = false;
      update();
    }
  }

  Future<void> onDownloadClick({required BuildContext context}) async {
    bool isLinkValid =
        RegExp(r'^(https?:\/\/)?(www\.)?[\w\-]+(\.[\w\-]+)+([\/#?]?.*)?$')
            .hasMatch(ytVideolinkController.text);
    if (ytVideolinkController.text.isEmpty || !isLinkValid) {
      AppMessageDialogs.commonSnackbar(
        context: context,
        message: "Please paste a valid link",
      );
    } else {
      try {
        isVideoDownloadCompleted = false;
        isLoading = true;
        update();
        await getYtVideoDetails(videoUrl: ytVideolinkController.text);
        isLoading = false;
        update();
        log("Video Fetched: ${videoModel?.videoTitle}");
        // method for showing the download bottom sheet
        if (videoModel != null) {
          downloadOptionsShowBottomSheet(
              context: context, isDownloading: isVideoDownloading);
        } else {
          AppMessageDialogs.commonSnackbar(
              context: context, message: "Unable to find the video");
        }
      } catch (e) {
        AppMessageDialogs.commonSnackbar(
            context: context, message: "Oops! An unexpected error occured");
        isLoading = false;
        update();
      }
    }
  }

  Future<void> downloadVideo() async {
    try {
      log("Selected video url: ${selectedVideoUrl}");
      updateIsVideoDownloading(value: true);
      final message = await videoRepository.downloadVideo(
          videoUrl: selectedVideoUrl,
          audioUrl: selectedAudioUrl,
          videoTitle:
              "${videoModel?.videoTitle}-${DateTime.now().millisecondsSinceEpoch}");
      if (message.isNotEmpty) {
        isVideoDownloadCompleted = true;
        update();
        AppMessageDialogs.commonSnackbar(
          context: AppGlobalKeys.navigatorKey.currentContext!,
          message: message,
        );
      }
    } catch (e) {
      isVideoDownloadCompleted = true;
      updateIsVideoDownloading(value: false);
      if (AppGlobalKeys.navigatorKey.currentContext != null) {
        AppMessageDialogs.commonSnackbar(
          context: AppGlobalKeys.navigatorKey.currentContext!,
          message: "Unable to download video",
        );
      }
    } finally {
      updateIsVideoDownloading(value: false);
    }
  }

  @override
  void dispose() {
    ytVideolinkController.dispose();
    super.dispose();
  }
}
