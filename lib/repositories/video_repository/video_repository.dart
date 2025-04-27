import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_video_downloader/controllers/home_page_controller.dart';
import 'package:youtube_video_downloader/controllers/video_play_page_controller.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoRepository {
  final YoutubeExplode youtubeExplode = YoutubeExplode();
  final Dio dio = Dio();
  Future<VideoModel?> getVideo({required String videoUrl}) async {
    try {
      final video = await youtubeExplode.videos.get(videoUrl);
      VideoModel videoFetched = VideoModel(
        videoId: video.id.value,
        videoTitle: video.title,
        videoUrl: video.url,
        videoThumbnailUrl: video.thumbnails.maxResUrl,
        videoDescription: video.description,
        videoDuration: video.duration,
      );
      return videoFetched;
    } catch (e) {
      log("Error occured on fetching video ${e.toString()}");
      return null;
    }
  }

Future<void> downloadVideo(String videoUrl) async {
  try {
    // Get the video info
    final video = await youtubeExplode.videos.get(videoUrl);
    final manifest = await youtubeExplode.videos.streamsClient.getManifest(video.id);

    // Get the highest quality muxed stream (audio + video together)
    final streamInfo = manifest.muxed.withHighestBitrate();

    final downloadUrl = streamInfo.url.toString();
    log("Download URL: $downloadUrl");

    // Asking for storage permission
    if (await Permission.storage.request().isGranted) {
      //Get directory to save
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      String newPath = "";
      List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/$folder";
        } else {
          break;
        }
      }
      newPath = "$newPath/Download";
      directory = Directory(newPath);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      String filePath = "${directory.path}/${video.title}.mp4";

      // Start downloading
      await dio.download(
        downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            String downloadProgress = (received / total * 100).toStringAsFixed(0);
            log("$downloadProgress%");
            Get.find<HomePageController>().setDownloadProgress(downloadProgress: downloadProgress);
          }
        },
      );

      log("Download completed: $filePath");
    } else {
      log("Permission Denied");
    }
  } catch (e) {
    log("Error downloading video: $e");
    throw Exception(e.toString());
  } finally {
    youtubeExplode.close();
  }
}


  Future<VideoModel?> fetchYtVideoDetails(
      String url) async {
    try {
      final video = await youtubeExplode.videos.get(url);
      final manifest = await youtubeExplode.videos.streamsClient.getManifest(video.id);

    List<Map<String, String>> qualities = [];

    for (var stream in manifest.muxed) {
      qualities.add({
        'quality': stream.qualityLabel ?? '',
        'url': stream.url.toString(),
      });
    }

    Map<String, String> videoQualityListWithUrl = {};
    for (var element in qualities) {
     videoQualityListWithUrl.addAll(element);
    }

    VideoModel fetchedVideoModel = VideoModel(
        videoId: video.id.value,
        videoTitle: video.title,
        videoUrl: video.url,
        videoThumbnailUrl: video.thumbnails.maxResUrl,
        videoDescription: video.description,
        videoDuration: video.duration,
        videoQualityListWithUrl: videoQualityListWithUrl,
    );

    return fetchedVideoModel;
    } catch (e) {
      log("Error on fetching video");
      throw Exception(e.toString());
    }
  }
}
