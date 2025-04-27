import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:youtube_video_downloader/components/common_button_container.dart';
import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:youtube_video_downloader/utils/functions/app_message_dialogs.dart';
import 'package:youtube_video_downloader/views/home_page/widgets/video_link_paste_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Get.find<HomePageController>().ytVideolinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "VidSwift",
            style: TextStyle(
                color: AppColors.kWhite,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.carterOne),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const VideoLinkPasteTextField(),
              AppConstraints.kHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButtonContainer(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    borderColor: AppColors.kTransparent,
                    buttonColor: AppColors.kBlackDarkShade,
                    buttonText: "Paste Link",
                    borderRadius: 10,
                    onTap: () {
                      Get.find<HomePageController>().pasteLink();
                    },
                  ),
                  AppConstraints.kWidth15,
                  CommonButtonContainer(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    buttonText: "Download",
                    borderColor: AppColors.kTransparent,
                    buttonColor: AppColors.kBlackDarkShade,
                    borderRadius: 10,
                    onTap: () {
                      Get.find<HomePageController>()
                          .onDownloadClick(context: context);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

