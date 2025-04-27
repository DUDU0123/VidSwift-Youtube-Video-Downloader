import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_video_downloader/repositories/video_repository/video_repository.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/home_page/utils/download_options_show_bottom_sheet.dart';
class HomePageController extends GetxController{
  TextEditingController ytVideolinkController = TextEditingController();
  VideoRepository videoRepository = VideoRepository();
  VideoModel? videoModel;
  String errorMessage = '';
  bool isLoading = false;
  String videoDownloadProgress = '0';
  void pasteLink(){
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      ytVideolinkController.text = value?.text ?? "";
   });
  }

  void clearField(){
    ytVideolinkController.text = '';
    update();
  }

  setDownloadProgress({required String downloadProgress,}){
    videoDownloadProgress =downloadProgress;
    update();
  }

 Future<void> getYtVideoDetails({required String videoUrl}) async {
  try {
    videoModel = await videoRepository.fetchYtVideoDetails(videoUrl);
    update();
  } catch (e) {
    errorMessage = "Oops! An unexpected error occured";
    isLoading = false;
    update();
  }
 }

  Future<void> onDownloadClick({required BuildContext context}) async {
    bool isLinkValid = RegExp(r'^(https?:\/\/)?(www\.)?[\w\-]+(\.[\w\-]+)+([\/#?]?.*)?$').hasMatch(ytVideolinkController.text);
    if(ytVideolinkController.text.isEmpty || !isLinkValid){
      AppMessageDialogs.commonSnackbar(
        context: context,
        message: "Please paste a valid Youtube video link",
      );
    }else{
      try {
        isLoading = true;
        update();
        await getYtVideoDetails(videoUrl: ytVideolinkController.text);
        isLoading = false;
        errorMessage = '';
        update();
        log("Video Fetched: ${videoModel?.videoTitle}");
        // method for showing the download bottom sheet
        downloadOptionsShowBottomSheet(context);
      } catch (e) {
         errorMessage = "Oops! An unexpected error occured";
        isLoading = false;
        update();
      }
    }
  }

  @override
  void dispose() {
    ytVideolinkController.dispose();
    super.dispose();
  }
}