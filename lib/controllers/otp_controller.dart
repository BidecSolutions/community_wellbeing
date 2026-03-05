import 'dart:convert';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final emailController = TextEditingController();
  String email = "";
  String confirmPassword = '';
  String newPassword = '';
  void setEmailAndCode(
    String userEmail,
    String confirmPassword,
    String newPassword,
  ) {
    email = userEmail;
  }

  Future<void> resetPassword() async {
    final newPassword = passwordController.text.trim();

    if (newPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a new password.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final url = Uri.parse('${AppSettings.baseUrl}auth/reset-password');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({
          "email": email,
          "confimPassword": confirmPassword,
          "newPassword": newPassword,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
          "Success",
          data['message'] ?? "Password reset successful.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login'); // Navigate to login or home
      } else {
        Get.snackbar(
          "Failed",
          data['message'] ?? "Failed to reset password.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Server error. Try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
