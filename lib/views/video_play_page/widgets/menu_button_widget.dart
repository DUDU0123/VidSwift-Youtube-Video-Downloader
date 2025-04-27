import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text("Share"),
          ),
          const PopupMenuItem(child: Text("Delete")),
        ];
      },
    );
  }
}