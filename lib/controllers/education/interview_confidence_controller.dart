import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InterviewConfidenceController extends GetxController {
  var isLoading = false.obs;
  var videos = <Map<String, dynamic>>[].obs;
  var category = <Map<String, dynamic>>[].obs;
  var selectedCategory = Rxn<Map<String, dynamic>>();

  Future<void> fetchClass() async {
    try {
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
      } else {
        Get.snackbar('Error', 'Failed to Load Classes');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVideos({int? videoId}) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/get-mock-interview',
      );
      final Map<String, dynamic> requestBody = {"status": 1};
      if (videoId != null) requestBody['job_id'] = videoId;

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
        // log('videos: $data');
        videos.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Classes');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
