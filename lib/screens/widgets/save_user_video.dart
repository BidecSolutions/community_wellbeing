import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../controllers/profile/test.dart';

class SaveUserVideo {
  final int videoId;
  final int module;

  SaveUserVideo({required this.videoId, required this.module});

  final isLoading = false.obs;
  final message = "".obs;

  Future<bool> fetchAllEvents() async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('${AppSettings.baseUrl}save-user-video'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"video_link_id": videoId, "module_id": module}),
      );
      log("STATUS: ${response.statusCode}");
      log("BODY: ${response.body}");
      log(
        "REQUEST BODY: ${jsonEncode({"video_link_id": videoId, "module_id": module})}",
      );

      if (response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        log("RESPONSE: $jsonBody");
        Get.snackbar(
          'Success',
          jsonBody['data']['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        if (jsonBody['data']['bookmarked'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        Get.snackbar(
          'Error',
          "Video Not Saved",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
