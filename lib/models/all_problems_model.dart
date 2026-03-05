import 'dart:ui';

class ProblemModel {
  final int id;
  final String problemName;
  final String icons;
  final int status;
  final String createdAt;
  final String updatedAt;
  final Color color;

  ProblemModel({
    required this.id,
    required this.problemName,
    required this.icons,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
  });

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['id'],
      problemName: json['problem_name'],
      icons: json['icons'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      color: _parseColor(json['color']),
    );
  }

  static Color _parseColor(String colorString) {
    colorString = colorString.toUpperCase().replaceAll("#", "");
    if (colorString.length == 6) {
      colorString = "FF$colorString"; // add opacity
    }
    return Color(int.parse("0x$colorString"));
  }
}
