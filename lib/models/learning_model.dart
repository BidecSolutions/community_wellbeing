class PlaylistVideoModel {
  final int id;
  final String thumbnailImage;
  final String thumbnailDescription;
  final int subjectId;
  final int classId;
  final int status;
  final List<VideoItemModel> videos;

  PlaylistVideoModel({
    required this.subjectId,
    required this.classId,
    required this.id,
    required this.thumbnailImage,
    required this.thumbnailDescription,
    required this.status,
    required this.videos,
  });

  factory PlaylistVideoModel.fromJson(Map<String, dynamic> json) {
    var list = (json['list'] ?? []) as List;
    List<VideoItemModel> videosList =
        list.map((i) => VideoItemModel.fromJson(i)).toList();

    return PlaylistVideoModel(
      id: json['id'] ?? 0,
      thumbnailImage: json['thumbnail_image'] ?? '',
      thumbnailDescription: json['thumbnail_description'] ?? '',
      status: json['status'] ?? 0,
      videos: videosList,
      subjectId: json['subject_id'] ?? 0,
      classId: json['class_id'] ?? 0,
    );
  }
}

class VideoItemModel {
  final int id;
  final String videoLink;
  final String videoHeading;
  final String videoDescription;
  final int thumbnailId;
  final int status;

  VideoItemModel({
    required this.id,
    required this.videoLink,
    required this.videoHeading,
    required this.videoDescription,
    required this.thumbnailId,
    required this.status,
  });

  factory VideoItemModel.fromJson(Map<String, dynamic> json) {
    return VideoItemModel(
      id: json['id'] ?? 0,
      videoLink: json['video_link'] ?? '',
      videoHeading: json['video_title'] ?? '',
      videoDescription: json['video_heading'] ?? '',
      thumbnailId: json['thumbnail_id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
