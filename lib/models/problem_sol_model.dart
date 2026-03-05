class ProblemSolutionModel {
  final int id;
  final int pId;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String problemName;

  ProblemSolutionModel({
    required this.id,
    required this.pId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.problemName,
  });

  factory ProblemSolutionModel.fromJson(Map<String, dynamic> json) {
    return ProblemSolutionModel(
      id: json['id'],
      pId: json['p_id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      problemName: json['problem_name'],
    );
  }
}
