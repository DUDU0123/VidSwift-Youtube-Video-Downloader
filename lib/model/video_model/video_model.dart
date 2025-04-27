import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String? videoId;
  final String? videoTitle;
  final String? videoDescription;
  final String? videoUrl;
  final String? videoThumbnailUrl;
  final Duration? videoDuration;
  final List<String>? availableVideoQualities;
  final Map<String, String>? videoQualityListWithUrl;
  const VideoModel({
    this.videoId,
    this.videoTitle,
    this.videoDescription,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.videoDuration,
    this.availableVideoQualities,
    this.videoQualityListWithUrl,
  });

  VideoModel copyWith({
    String? videoId,
    String? videoTitle,
    String? videoDescription,
    String? videoUrl,
    String? videoThumbnailUrl,
    Duration? videoDuration,
    List<String>? availableVideoQualities,
    Map<String, String>? videoQualityListWithUrl,
  }) {
    return VideoModel(
      videoId: videoId ?? this.videoId,
      videoTitle: videoTitle ?? this.videoTitle,
      videoDescription: videoDescription ?? this.videoDescription,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
      videoDuration: videoDuration ?? this.videoDuration,
      videoQualityListWithUrl: videoQualityListWithUrl ?? this.videoQualityListWithUrl,
      availableVideoQualities: availableVideoQualities ?? this.availableVideoQualities,
    );
  }

  @override
  List<Object?> get props {
    return [
      videoId,
      videoTitle,
      videoDescription,
      videoUrl,
      videoThumbnailUrl,
      videoDuration,
      availableVideoQualities,
      videoQualityListWithUrl,
    ];
  }
}
