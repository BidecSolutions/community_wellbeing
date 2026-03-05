class VideoModel {
  final int id;
  final String thumbnailImage;
  final String thumbnailDescription;
  final int languageId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<VideoItemModel> videos;

  VideoModel({
    required this.id,
    required this.thumbnailImage,
    required this.thumbnailDescription,
    required this.languageId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<VideoItemModel> videosList =
        list.map((i) => VideoItemModel.fromJson(i)).toList();

    return VideoModel(
      id: json['id'],
      thumbnailImage: json['thumbnail_image'],
      thumbnailDescription: json['thumbnail_description'],
      languageId: json['language_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      videos: videosList,
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
      id: json['id'],
      videoLink: json['video_link'],
      videoHeading: json['video_heading'],
      videoDescription: json['video_description'],
      thumbnailId: json['thumbnail_id'],
      status: json['status'],
    );
  }
}

class LanguageModel {
  final int id;
  final String name;

  LanguageModel({required this.id, required this.name});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(id: json['id'], name: json['name']);
  }
}
