import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as d;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_video_downloader/model/video_model/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_video_downloader/utils/constants/app_global_imports.dart';
import 'package:path/path.dart' as p;

class VideoRepository {
  final YoutubeExplode youtubeExplode = YoutubeExplode();
  final d.Dio dio = d.Dio();
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
        directory = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
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
        options: d.Options(responseType: d.ResponseType.bytes),
      );
      final videoFile = File(videoFilePath);
      await videoFile
          .writeAsBytes(Uint8List.fromList(videoDownloadResponse.data!));
      d.Response<List<int>>? audioDownloadResponse;
      // Downloading audio
      try {
        audioDownloadResponse = await dio.get<List<int>>(
        audioUrl,
        options: d.Options(responseType: d.ResponseType.bytes),
      );
      } catch (e) {
        debugPrint("No audio file for this video");
      }
      final audioFile = File(audioFilePath);
      if (audioDownloadResponse!=null && audioDownloadResponse.data!=null) {
        await audioFile
          .writeAsBytes(Uint8List.fromList(audioDownloadResponse.data!));
      }

      if (!await audioFile.exists()) {
        return "Unable to download audio for this video";
      }
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
          if (await videoFile.exists()) {
            await videoFile.delete();
          }
          if (await audioFile.exists()) {
            await audioFile.delete();
          }
          debugPrint("Temporary files deleted.");
        } catch (e) {
          debugPrint("Failed to delete temp files: $e");
        }

        return "Video downloaded successfully";
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

  // get all downloaded videos

  Future<List<VideoModel>> getAllDownloadedVideos() async {
    try {
      Directory directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      List<FileSystemEntity> files = directory.listSync();

      List<FileSystemEntity> videoFiles = files.where((file) {
        return file.path.endsWith('-combined.mp4');
      }).toList();

      List<VideoModel> videoModels = [];

      for (var file in videoFiles) {
        final fileName = p.basename(file.path); // e.g., 'myvideo-combined.mp4'
        final fileTitle = fileName.replaceAll('-combined.mp4', '');

        // Generate thumbnail
        final thumbnail = await VideoThumbnail.thumbnailFile(
          video: file.path,
          thumbnailPath:
              (await getTemporaryDirectory()).path, // save temp thumbnail
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        );

       final thumbnailPath=File(thumbnail.path);

        videoModels.add(
          VideoModel(
            videoId: file.path,
            videoTitle: fileTitle,
            videoUrl: file.path,
            videoThumbnail: thumbnailPath,
          ),
        );
      }

      return videoModels;
    } catch (e) {
      debugPrint('Error listing video models with thumbnails: $e');
      return [];
    }
  }
}
