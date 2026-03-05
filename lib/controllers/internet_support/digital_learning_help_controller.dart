import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/digital_learning.dart';

class DigitalLearningHelpController extends GetxController {
  var apiVideoLinks = <DigitalLearning>[].obs;
  var isLoading = false.obs;
  final pageHeading = ''.obs;
  final pageDescription = ''.obs;

  Future<void> fetchVideo() async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}internet-support/digital-learning-video');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final List videos = data['data'];
      apiVideoLinks.value = videos.map((item) => DigitalLearning.fromJson(item)).toList();
    } else {
      log('Digital Learning Help API Error: ${response.statusCode}');
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchVideo();
  }
}
