import 'dart:convert';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendResetRequest() async {
    final email = emailOrPhoneController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;

    try {
      final url = Uri.parse('${AppSettings.baseUrl}auth/forgot-password');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
          "Request Sent",
          data['message'] ?? "Check your email for reset instructions.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed('/otpScreen', arguments: {'email': email});
      } else {
        Get.snackbar(
          "Failed",
          data['message'] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send request. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String email, String code) async {
    final url = Uri.parse('${AppSettings.baseUrl}auth/verify-reset-code');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "code": code}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        Get.toNamed('/newPasswordScreen');
      } else {
        Get.snackbar(
          "Invalid OTP",
          data['message'] ?? "The OTP you entered is incorrect",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to verify OTP. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    super.onClose();
  }
}
