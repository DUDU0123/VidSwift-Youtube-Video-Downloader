import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';

class VideoRepository {
  final YoutubeExplode youtubeExplode = YoutubeExplode();
  final Dio dio = Dio();
    Future<String> downloadVideo({
  required String videoUrl,
  required String audioUrl,
  required String videoTitle,
}) async {
  try {
    // Requesting storage permission
    await Permission.storage.request();

    // Getting appropriate storage directory
    Directory directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    // Define file paths
    String videoFilePath = '${directory.path}/$videoTitle-video.mp4';
    String audioFilePath = '${directory.path}/$videoTitle-audio.mp4';
    String outputFilePath = '${directory.path}/$videoTitle-combined.mp4';

    // Downloading video
    final videoDownloadResponse = await dio.get<List<int>>(
      videoUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    final videoFile = File(videoFilePath);
    await videoFile.writeAsBytes(Uint8List.fromList(videoDownloadResponse.data!));

    // Downloading audio
    final audioDownloadResponse = await dio.get<List<int>>(
      audioUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    final audioFile = File(audioFilePath);
    await audioFile.writeAsBytes(Uint8List.fromList(audioDownloadResponse.data!));

    // Building FFmpeg command
    final String ffmpegCommand = 
      '-i "$videoFilePath" -i "$audioFilePath" -map 0:v -map 1:a -c:v copy -c:a aac "$outputFilePath"';

    // Execute FFmpeg command
    final result = await FFmpegKit.execute(ffmpegCommand);
    final returnCode = await result.getReturnCode();

    if (returnCode == null) {
      return "Unable to download video";
    }

    if (returnCode.isValueSuccess()) {
      debugPrint("Video and audio successfully merged at: $outputFilePath");

      // deleting video and audio file after storing video to device app storge
      try {
        await videoFile.delete();
        await audioFile.delete();
        debugPrint("Temporary files deleted.");
      } catch (e) {
        debugPrint("Failed to delete temp files: $e");
      }

      return "Video downloaded successfully: $outputFilePath";
    } else {
      debugPrint("Error merging streams: ${returnCode.getValue()}");
      return "Unable to download video";
    }
  } catch (e) {
    debugPrint('Error downloading video: $e');
    throw Exception("Unable to download video");
  }
}

  Future<VideoModel?> fetchYtVideoDetails(String url) async {
    try {
      final video = await youtubeExplode.videos.get(url);
      final manifest =
          await youtubeExplode.videos.streamsClient.getManifest(video.id);

      List<Map<String, String>> videoQualities = [];
      List<Map<String, String>> audioQualities = [];
      for (var stream in manifest.videoOnly) {
        log("Quality: ${stream.videoQuality} ${stream.qualityLabel}");
        videoQualities.add({
          'quality': stream.qualityLabel ?? '',
          'url': stream.url.toString(),
        });

        for (var audioStream in manifest.audioOnly) {
          audioQualities.add({
            'quality': stream.qualityLabel,
            'url': audioStream.url.toString(),
          });
        }
      }

      VideoModel fetchedVideoModel = VideoModel(
        videoId: video.id.value,
        videoTitle: video.title,
        videoUrl: video.url,
        videoThumbnailUrl: video.thumbnails.maxResUrl,
        videoDescription: video.description,
        videoDuration: video.duration,
        videoQualityListWithUrl: videoQualities,
        audioQualityListWithUrl: audioQualities,
      );

      return fetchedVideoModel;
    } catch (e) {
      log("Error on fetching video ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
