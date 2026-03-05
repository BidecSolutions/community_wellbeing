class JobModel {
  final String companyName;
  final String companyLogo;
  final String companyAddress;
  final String companyContact;
  final String companyEmail;
  final int categoryId;
  final String categoryName;
  final String levelName;
  final String sa2;
  final int sa2Id;
  final String jobTitle;
  final int jobType;
  final int payType;
  final int experienceLevel;
  final String latitude;
  final String longitude;
  final String details;
  final bool isPublished;
  final int jobId;
  final DateTime jobPostedDate;
  int viewed;
  int applied;

  JobModel({
    required this.categoryId,
    required this.sa2Id,
    required this.companyName,
    required this.companyLogo,
    required this.companyAddress,
    required this.companyContact,
    required this.companyEmail,
    required this.categoryName,
    required this.levelName,
    required this.sa2,
    required this.jobTitle,
    required this.jobType,
    required this.payType,
    required this.latitude,
    required this.longitude,
    required this.experienceLevel,
    required this.details,
    required this.isPublished,
    required this.jobId,
    required this.jobPostedDate,
    required this.viewed,
    required this.applied,
  });

  // Factory Constructor (fromJson)
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      companyName: json['company_name'] ?? '',
      companyLogo: json['company_logo'] ?? '',
      companyAddress: json['company_address'] ?? '',
      companyContact: json['company_contact'] ?? '',
      companyEmail: json['company_email'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryId: json['job_category_id'] ?? '',
      levelName: json['level_name'] ?? '',
      sa2: json['Sa2'] ?? '',
      jobTitle: json['job_title'] ?? '',
      jobType: json['job_type'] ?? -1,
      payType: json['pay_type'] ?? -1,
      latitude: json['latitute'] ?? '',
      longitude: json['longitude'] ?? '',
      experienceLevel: json['experience_level'] ?? -1,
      details: json['details'] ?? ' ',
      isPublished: json['is_published'] == 1,
      jobId: json['jobId'] ?? 0,
      jobPostedDate: DateTime.parse(json['job_posted_date'] ?? ''),
      viewed: json['viewed'] ?? '',
      applied: json['applied'] ?? '',
      sa2Id: json['sa2_id'] ?? '',
    );
  }
}
