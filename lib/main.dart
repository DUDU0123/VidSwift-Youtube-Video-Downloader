import 'package:youtube_video_downloader/utils/functions/init_controllers.dart';
import 'package:youtube_video_downloader/views/root_widget_page.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  runApp(
    const RootWidgetPage()
  );
}