import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScholarshipHubController extends GetxController {
  var isLoading = false.obs;
  var level = <Map<String, dynamic>>[].obs;
  var selectedLevel = Rxn<Map<String, dynamic>>();
  var funds = <Map<String, dynamic>>[].obs;
  var selectedFunds = Rxn<Map<String, dynamic>>();
  var allScholarships = <Map<String, dynamic>>[].obs; // raw API data
  var scholarships = <Map<String, dynamic>>[].obs;

  Future<void> fetchLevel() async {
    isLoading.value = true;
    final url = Uri.parse(
      '${AppSettings.baseUrl}education/get-scholarships-levels',
    );
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
      log('level: $data');
      level.value = List<Map<String, dynamic>>.from(data);
    } else {
      Get.snackbar('Error', 'Failed to Load Level');
    }
    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFunds() async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}education/get-fund-types');
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
      log('fund: $data');
      funds.value = List<Map<String, dynamic>>.from(data);
    } else {
      Get.snackbar('Error', 'Failed to Load Funds');
    }
    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchScholarships() async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}education/get-scholarships');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"status": 1}), // no filter → get all
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      allScholarships.value = List<Map<String, dynamic>>.from(data);
      scholarships.assignAll(allScholarships); // show all by default
    } else {
      Get.snackbar('Error', 'Failed to Load Scholarships');
    }

    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🔑 Local filter function
  void filterScholarships() {
    scholarships.value =
        allScholarships.where((item) {
          final matchLevel =
              selectedLevel.value == null ||
              item['scholarship_level_id'] == selectedLevel.value?['id'];
          final matchFund =
              selectedFunds.value == null ||
              item['funding_type_id'] == selectedFunds.value?['id'];
          return matchLevel && matchFund;
        }).toList();
  }
}
