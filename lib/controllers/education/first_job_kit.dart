import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FirstJobKitController extends GetxController {
  var isLoading = false.obs;
  var category = <Map<String, dynamic>>[].obs;
  var selectedCategory = Rxn<Map<String, dynamic>>();
  var jobKit = <Map<String, dynamic>>[].obs;
  // Selected child and age group index
  final RxnString selectedLeftValue = RxnString(); // Child's name
  final RxInt selectedRightIndex = 0.obs; // Age group index

  // Checklist state
  final RxList<String> currentChecklistGroups = <String>[].obs;
  final RxList<bool> isCheckedList = <bool>[].obs;

  Future<void> fetchClass() async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}jobs/job-categories');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"status": 1}),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      category.value = List<Map<String, dynamic>>.from(data);
      // log('jobs: $data');
    } else {
      Get.snackbar('Error', 'Failed to Load Jobs');
    }
    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Full milestone data grouped by category per age group
  // final List<String> allMilestoneData = [
  //   'Do you have a CV or resume already?',
  //   'Are you confident with job interviews?',
  //   'Do you have an IRD number.',
  //   'I understand workplace behaviour and expectations.',
  //   'I can talk about my skills and strengths.',
  //   'I know what to wear to an interview.',
  //   'I can explain my work or school experience clearly.',
  //   'I feel ready to start my first job.',
  //   'I can explain why I want a particular job.',
  //   'I feel confident introducing myself to a new employer.',
  //   'I know how to follow up after a job interview.',
  // ];
  // Computed progress
  double get progress {
    if (isCheckedList.isEmpty) return 0.0;
    return isCheckedList.where((checked) => checked).length /
        isCheckedList.length;
  }

  Future<void> fetchJobKit({int? kitId}) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/get-job-kit-points',
      );
      final Map<String, dynamic> requestBody = {
        "questionType": "education",
        "status": 1,
      };
      if (kitId != null) requestBody['job_title_id'] = kitId;

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        // 🔥 Filter based on selected kitId
        final filtered =
            kitId != null
                ? data.where((item) => item['job_title_id'] == kitId).toList()
                : data;

        jobKit.value = List<Map<String, dynamic>>.from(filtered);
        isCheckedList.value = List.filled(jobKit.length, false);
      } else {
        Get.snackbar('Error', 'Failed to Load Videos');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize default selections
    // selectedLeftValue.value = leftDropdownItems.first;
    selectedRightIndex.value = 0;

    // Setup listeners
    ever(selectedRightIndex, (_) {
      _updateChecklistAndResetProgress();
    });

    ever(selectedLeftValue, (_) {
      _clearChecklistAndProgress();
      // Optional: force age group re-selection or keep it unchanged
    });

    _updateChecklistAndResetProgress(); // Initial load
  }

  // Update checklist and reset progress when age group changes
  void _updateChecklistAndResetProgress() {
    fetchJobKit();

    _resetProgressForCurrentChecklist();
  }

  // Resets the checklist check states
  void _resetProgressForCurrentChecklist() {
    isCheckedList.clear();
    isCheckedList.addAll(List.filled(jobKit.length, false));
  }

  // Clear checklist and progress (used when changing child)
  void _clearChecklistAndProgress() {
    jobKit.clear();
    isCheckedList.clear();
  }

  // Optional helper if you want all items in one flat list
  List<Map<String, dynamic>> getAllChecklistItems() {
    return jobKit.toList();
  }
}
