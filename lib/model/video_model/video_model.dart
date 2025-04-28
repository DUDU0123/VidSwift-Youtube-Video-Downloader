import 'dart:io';

import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String? videoId;
  final String? videoTitle;
  final String? videoDescription;
  final String? videoUrl;
  final File? videoThumbnail;
  final Duration? videoDuration;
  final List<String>? availableVideoQualities;
  final List<Map<String, String>>? videoQualityListWithUrl;
  final List<Map<String, String>>? audioQualityListWithUrl;
  const VideoModel({
    this.videoId,
    this.videoTitle,
    this.videoDescription,
    this.videoUrl,
    this.videoThumbnail,
    this.videoDuration,
    this.availableVideoQualities,
    this.videoQualityListWithUrl,
    this.audioQualityListWithUrl,
  });

  VideoModel copyWith({
    String? videoId,
    String? videoTitle,
    String? videoDescription,
    String? videoUrl,
    File? videoThumbnail,
    Duration? videoDuration,
    List<String>? availableVideoQualities,
    List<Map<String, String>>? videoQualityListWithUrl,
    List<Map<String, String>>? audioQualityListWithUrl,
  }) {
    return VideoModel(
      videoId: videoId ?? this.videoId,
      videoTitle: videoTitle ?? this.videoTitle,
      videoDescription: videoDescription ?? this.videoDescription,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      videoDuration: videoDuration ?? this.videoDuration,
      videoQualityListWithUrl: videoQualityListWithUrl ?? this.videoQualityListWithUrl,
      availableVideoQualities: availableVideoQualities ?? this.availableVideoQualities,
      audioQualityListWithUrl: audioQualityListWithUrl ?? this.audioQualityListWithUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      videoId,
      videoTitle,
      videoDescription,
      videoUrl,
      videoThumbnail,
      videoDuration,
      availableVideoQualities,
      videoQualityListWithUrl,
      audioQualityListWithUrl,
    ];
  }
}
