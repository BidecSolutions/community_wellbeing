import 'package:community_app/app_settings/settings.dart';

class SafetyAwarenessModel {
  final int id;
  final String name;
  final String icon;
  final String color;
  final String innerPageHeading;
  final String innerPageDescription;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SafetyAwarenessModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.innerPageHeading,
    required this.innerPageDescription,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SafetyAwarenessModel.fromJson(Map<String, dynamic> json) =>
      SafetyAwarenessModel(
        id: json["id"],
        name: json["name"],
        icon: AppSettings.baseUrl + json["icon"],
        color: json["color"],
        innerPageHeading: json["inner_page_heading"],
        innerPageDescription: json["inner_page_description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class ChildSafetyModel {
  final int id;
  final int categoryId;
  final String videoLink;
  final String videoHeading;
  final String videoDescription;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;

  ChildSafetyModel({
    required this.id,
    required this.categoryId,
    required this.videoLink,
    required this.videoHeading,
    required this.videoDescription,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
  });

  factory ChildSafetyModel.fromJson(Map<String, dynamic> json) =>
      ChildSafetyModel(
        id: json["id"],
        categoryId: json["category_id"],
        videoLink: json["video_link"],
        videoHeading: json["video_heading"],
        videoDescription: json["video_description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryName: json["category_name"],
      );
}
