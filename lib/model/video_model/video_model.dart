import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String? videoId;
  final String? videoTitle;
  final String? videoDescription;
  final String? videoUrl;
  final String? videoThumbnailUrl;
  final Duration? videoDuration;
  final List? videoResolutions;
  const VideoModel({
    this.videoId,
    this.videoTitle,
    this.videoDescription,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.videoDuration,
    this.videoResolutions,
  });

  @override
  List<Object?> get props {
    return [
      videoId,
      videoTitle,
      videoDescription,
      videoUrl,
      videoThumbnailUrl,
      videoDuration,
      videoResolutions,
    ];
  }
}
