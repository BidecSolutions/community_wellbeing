class ChildSafety {
  final int id;
  final int categoryId;
  final String videoLink;
  final String videoHeading;
  final String videoDescription;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;

  ChildSafety({
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

  factory ChildSafety.fromJson(Map<String, dynamic> json) => ChildSafety(
    id: json["id"] ?? 0,
    categoryId: json["category_id"] ?? 0,
    videoLink: json["video_link"] ?? '',
    videoHeading: json["video_heading"] ?? '',
    videoDescription: json["video_description"] ?? '',
    status: json["status"] ?? 0,
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
    categoryName: json["category_name"] ?? '',
  );
}

class McQs {
  final int id;
  final String questions;
  final int status;
  final List<Ans> ans;
  final int rightAnswer;

  int? selectedAnswerIndex;

  McQs({
    required this.rightAnswer,
    required this.id,
    required this.questions,
    required this.status,
    required this.ans,
    this.selectedAnswerIndex,
  });

  factory McQs.fromJson(Map<String, dynamic> json) {
    return McQs(
      id: json["id"] ?? 0,
      questions: json["questions"] ?? '',
      status: json["status"] ?? 0,
      rightAnswer: json["right_answer"] ?? 0,
      ans: json["ans"] != null
          ? List<Ans>.from(json["ans"].map((x) => Ans.fromJson(x)))
          : [],
    );
  }
}

class Ans {
  final int id;
  final int questionsId;
  final String options;
  final int status;

  Ans({
    required this.id,
    required this.questionsId,
    required this.options,
    required this.status,
  });

  factory Ans.fromJson(Map<String, dynamic> json) => Ans(
    id: json["id"] ?? 0,
    questionsId: json["questions_id"] ?? 0,
    options: json["options"] ?? '',
    status: json["status"] ?? 0,
  );
}
