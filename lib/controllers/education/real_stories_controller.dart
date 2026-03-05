import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RealStoriesController extends GetxController {
  var isLoading = false.obs;
  var stories = <Map<String, dynamic>>[].obs;

  Future<void> fetchStories() async {
    isLoading.value = true;
    final url = Uri.parse(
      '${AppSettings.baseUrl}education/get-inspirational-stories',
    );
    final Map<String, dynamic> requestBody = {"status": 1};

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
      log('videos: $data');
      stories.value = List<Map<String, dynamic>>.from(data);
    } else {
      Get.snackbar('Error', 'Failed to Load Scholarships');
    }
    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
