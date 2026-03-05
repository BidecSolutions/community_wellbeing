import 'dart:convert';

class SuggestionList {
  final int id;
  final String name;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SuggestionList({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SuggestionList.fromJson(Map<String, dynamic> json) => SuggestionList(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class CategorySuggestionList {
  final int id;
  final int suggestionId;
  final String categoryName;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String suggestionName;

  CategorySuggestionList({
    required this.id,
    required this.suggestionId,
    required this.categoryName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.suggestionName,
  });

  factory CategorySuggestionList.fromJson(Map<String, dynamic> json) =>
      CategorySuggestionList(
        id: json["id"],
        suggestionId: json["suggestion_id"],
        categoryName: json["category_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        suggestionName: json["suggestion_name"],
      );
}

class SuggestionCategoryDetails {
  final int id;
  final int suggestionCategoryId;
  final String suggestionHeading;
  final String boxColor;
  final List<String> details;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;

  SuggestionCategoryDetails({
    required this.id,
    required this.suggestionCategoryId,
    required this.suggestionHeading,
    required this.boxColor,
    required this.details,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
  });

  factory SuggestionCategoryDetails.fromJson(Map<String, dynamic> json) =>
      SuggestionCategoryDetails(
        id: json["id"],
        suggestionCategoryId: json["suggestion_category_id"],
        suggestionHeading: json["suggestion_heading"],
        boxColor: json["box_color"],
        details:
            json["details"] is String
                ? List<String>.from(jsonDecode(json["details"]))
                : List<String>.from(json["details"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryName: json["category_name"],
      );
}
