import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/learning_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LearningModuleController extends GetxController {
  var isLoading = false.obs;
  var classes = <Map<String, dynamic>>[].obs;
  var subjects = <Map<String, dynamic>>[].obs;
  var videos = <Map<String, dynamic>>[].obs;
  var playlistVideos = <PlaylistVideoModel>[].obs;
  var selectedSubject = Rxn<Map<String, dynamic>>();
  var selectedClass = Rxn<Map<String, dynamic>>();
  var className = ''.obs;
  var classId = 0.obs;
  var subjectName = ''.obs;
  var subjectId = 0.obs;

  Future<void> fetchSubject() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${AppSettings.baseUrl}education/get-all-subjects');
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
        subjects.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Subject');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchClass() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${AppSettings.baseUrl}education/get-all-class');
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
        classes.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Classes');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVideos({int? subjectId, int? classId}) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/get-interactive-learning',
      );
      final Map<String, dynamic> requestBody = {"status": 1};
      if (subjectId != null) requestBody['subject_id'] = subjectId;
      if (classId != null) requestBody['class_id'] = classId;

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
        videos.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Videos');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPlaylistVideos({int? subjectId, int? classId}) async {
    final url = Uri.parse('${AppSettings.baseUrl}education/get-self-learning');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"status": 1}), // only status for now
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final data = jsonResponse['data'];

      if (data is Map<String, dynamic> && data['thumbnailVideos'] is List) {
        playlistVideos.clear();

        for (var item in data['thumbnailVideos']) {
          final playlist = PlaylistVideoModel.fromJson(item);

          if ((subjectId == null || playlist.subjectId == subjectId) &&
              (classId == null || playlist.classId == classId)) {
            playlistVideos.add(playlist);
          }
        }

        update();
      } else {
        log("Unexpected data format: $data");
      }
    } else {
      log("Unexpected response: $jsonResponse");
    }
  }
}
