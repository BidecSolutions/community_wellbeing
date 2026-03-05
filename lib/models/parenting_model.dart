class VideoLinks {
  final String id;
  final String label;
  final String des;

  VideoLinks({required this.id, required this.label, required this.des});

  factory VideoLinks.fromJson(Map<String, dynamic> json) {
    return VideoLinks(
      id: json['video_link'] ?? '',
      label: json['title'] ?? '',
      des: json['description'] ?? '',
    );
  }
}

class MentalHealthSupport {
  final int id;
  final int pageId;
  final String videoLink;
  final String label;
  final String description;

  MentalHealthSupport({
    required this.id,
    required this.pageId,
    required this.videoLink,
    required this.label,
    required this.description,
  });

  factory MentalHealthSupport.fromJson(Map<String, dynamic> json) {
    return MentalHealthSupport(
      id: json["id"] ?? '',
      pageId: json["page_id"] ?? 0,
      videoLink: json["video_link"] ?? '',
      label: json["heading"] ?? '',
      description: json["sub_heading"] ?? '',
    );
  }
}

class LearnPage {
  final int id;
  final String label;
  final String des;
  final String images;
  LearnPage({
    required this.id,
    required this.label,
    required this.des,
    required this.images,
  });
  factory LearnPage.fromJson(Map<String, dynamic> json) {
    return LearnPage(
      id: json['id'] ?? '',
      label: json['heading'] ?? '',
      des: json['description'] ?? '',
      images: json['image'] ?? '',
    );
  }
}

class ResourcePagesVideoLink {
  final String id;
  final String title;
  final String des;
  ResourcePagesVideoLink({
    required this.id,
    required this.title,
    required this.des,
  });
  factory ResourcePagesVideoLink.fromJson(Map<String, dynamic> json) {
    return ResourcePagesVideoLink(
      id: json['video_link'] ?? '',
      title: json['title'] ?? '',
      des: json['description'] ?? '',
    );
  }
}
