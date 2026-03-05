import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/job_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JobController extends GetxController {
  DateTime postedAt = DateTime.parse("2025-07-24 00:00:00");
  RxString timeAgo = ''.obs;
  Timer? _timer;
  final RxList<JobModel> jobs = <JobModel>[].obs;
  final RxList<JobModel> allJobs = <JobModel>[].obs;
  RxList<JobModel> displayedJobs = <JobModel>[].obs; // Paginated data
  RxList<Map<String, dynamic>> sa2List = <Map<String, dynamic>>[].obs;
  Rxn<Map<String, dynamic>> selectedCategory = Rxn<Map<String, dynamic>>();
  Rxn<Map<String, dynamic>> selectedSA2 = Rxn<Map<String, dynamic>>();

  final int perPage = 10;
  int currentPage = 0;
  RxBool isLoadingMore = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var errorMessage1 = ''.obs;
  // final selectedSA2 = 0.obs;
  final offset = 0.obs;
  final limit = 10;

  void filterJobsByCategory() {
    final selectedId = selectedCategory.value?['id'];
    if (selectedId == null) return;
    final filtered =
        allJobs
            .where((job) => job.categoryId == selectedCategory.value)
            .toList();

    jobs.value = filtered;
    displayedJobs.clear();
    currentPage = 0;
    loadMoreJobs();
  }

  void loadSA2ForSelectedCategory() {
    if (selectedCategory.value == null) return;

    final selectedCatId = selectedCategory.value?['id'];

    if (selectedCatId != null) {
      final sa2ForCategory =
          allJobs
              .where((job) => job.categoryId == selectedCatId)
              .map((job) => {'id': job.sa2Id, 'name': job.sa2})
              .toSet()
              .toList();

      // Remove duplicates
      final uniqueSa2 =
          {for (var item in sa2ForCategory) item['id']: item}.values.toList();

      sa2List.value = uniqueSa2;
    } else {
      sa2List.value = [];
    }
  }

  List<Map<String, dynamic>> get uniqueCategories {
    final seen = <int>{};
    return allJobs
        .where((job) => seen.add(job.categoryId))
        .map((job) => {'id': job.categoryId, 'name': job.categoryName})
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _updateTimeAgo();
    _timer = Timer.periodic(Duration(minutes: 1), (_) => _updateTimeAgo());
    fetchJobs();
  }

  Future<void> fetchJobs({
    String status = "1",
    String published = "1",
    String category = "",
    String level = "",
    String company = "",
    String fromDate = "",
    String toDate = "",
  }) async {
    isLoadingMore.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}jobs/show-jobs');
    final nextOfSet = offset.value == 0 ? 0 : offset.value + 10;
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        'status': 1,
        'published': 1,
        "offset": nextOfSet,
        "limit": 10,
        'category': category,
        'level': level,
        'company': company,
        'fromDate': fromDate,
        'toDate': toDate,
      }),
    );
    // log("Raw response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final apiResponse = jsonDecode(response.body);
      final List<dynamic> data = apiResponse['data']?? [];
      final List<JobModel> newJobs =
          data.map((json) => JobModel.fromJson(json)).toList();
      jobs.addAll(newJobs);
      allJobs.addAll(newJobs);
      offset.value += 10;
    } else {
      errorMessage1.value = 'Failed to load jobs: ${response.statusCode}';
    }
    try {} catch (e) {
      log("Fetch job error: $e");
      e;
    }
  }

  void loadMoreJobs() {
    fetchJobs();
  }

  void _updateTimeAgo() {
    timeAgo.value = formatTimeAgo(postedAt);
  }

  String formatTimeAgo(DateTime postedDate) {
    final now = DateTime.now();
    final diff = now.difference(postedDate);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'}';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'}';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'}';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'}';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'}';
    }
  }

  String getJobTypeText(int value) {
    switch (value) {
      case 1:
        return 'Onsite';
      case 2:
        return 'Remote';
      case 3:
        return 'Part Time';
      case 4:
        return 'Full Time';
      case 5:
        return 'Freelance';
      default:
        return 'Unknown Job Type';
    }
  }

  String getPayTypeText(int value) {
    switch (value) {
      case 1:
        return 'Hourly';
      case 2:
        return 'Monthly';
      case 3:
        return 'Fixed';
      case 4:
        return 'Daily Wages';
      default:
        return 'Unknown Pay Type';
    }
  }

  String getExperienceLevelText(int value) {
    switch (value) {
      case 1:
        return 'Intern';
      case 2:
        return 'Beginner';
      case 3:
        return 'Junior';
      case 4:
        return 'Mid';
      case 5:
        return 'Senior';
      case 6:
        return 'Professional';
      default:
        return 'Unknown Experience Level';
    }
  }

  bool jobVisibility(int value) {
    return value == 1;
  }

  final address = TextEditingController();
  var incomeFilePath = ''.obs;

  Future<void> pickIncomeVerificationFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      incomeFilePath.value = result.files.single.path!;
    }
  }

  Future<bool> applyForJob({required String type, required int jobID}) async {
    final url = Uri.parse('${AppSettings.baseUrl}jobs/apply-for-job');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});

    final hasCVInProfile = (box.read('cv_link') ?? '').toString().isNotEmpty;
    final hasFilePath = incomeFilePath.value.isNotEmpty;
    final fileToUpload = hasFilePath ? File(incomeFilePath.value) : null;

    if (type != 'view') {
      if (address.text.isEmpty) {
        errorMessage.value = "Please Enter the Address";
        return false;
      }
      if (!hasCVInProfile && fileToUpload == null) {
        errorMessage.value = "Please upload your CV.";
        return false;
      }

      if (fileToUpload != null) {
        request.files.add(
          await http.MultipartFile.fromPath('cv', fileToUpload.path),
        );
      }
    }

    request.fields['type'] = type;
    request.fields['jobId'] = jobID.toString();
    final response = await request.send();
    if (response.statusCode == 201) {
      // fetchJobs();
      address.clear();
      errorMessage.value = "CV Send Successfully";
      return true;
    } else {
      errorMessage.value = "Request Not Sent Try Again ";
      return false;
    }
  }
  //Murad Work end

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
