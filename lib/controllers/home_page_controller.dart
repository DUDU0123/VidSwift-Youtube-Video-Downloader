import 'package:flutter/services.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/views/home_page/utils/download_options_show_bottom_sheet.dart';
class HomePageController extends GetxController{
  TextEditingController ytVideolinkController = TextEditingController();
  void pasteLink(){
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      ytVideolinkController.text = value?.text ?? "";
   });
  }

  void onDownloadClick({required BuildContext context}){
    bool isLinkValid = RegExp(r'^(https?:\/\/)?(www\.)?[\w\-]+(\.[\w\-]+)+([\/#?]?.*)?$').hasMatch(ytVideolinkController.text);
    if(ytVideolinkController.text.isEmpty || !isLinkValid){
      AppMessageDialogs.commonSnackbar(
        context: Get.context!,
        message: "Please paste a valid Youtube video link",
      );
    }else{
      // method for showing the download bottom sheet
      downloadOptionsShowBottomSheet(context);
    }
  }

  @override
  void dispose() {
    ytVideolinkController.dispose();
    super.dispose();
  }
}