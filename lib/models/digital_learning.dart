class DigitalLearning {
  final int id;
  final String videoLink;
  final String label;
  final String description;

  DigitalLearning({
    required this.id,
    required this.videoLink,
    required this.label,
    required this.description,
  });

  factory DigitalLearning.fromJson(Map<String, dynamic> json) {
    return DigitalLearning(
      id: json["id"] ?? '',
      videoLink: json["video_link"] ?? '',
      label: json["video_title"] ?? '',
      description: json["video_description"] ?? '',
    );
  }
}