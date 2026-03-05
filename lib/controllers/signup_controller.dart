import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../app_settings/settings.dart';
import '../screens/widgets/snack_bar.dart';

class SignupController extends GetxController {
  // Text controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  // Error messages
  final nameError = ''.obs;
  final emailError = ''.obs;
  final phoneError = ''.obs;
  final passwordError = ''.obs;

  // Password visibility
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  void togglePassword() => isPasswordHidden.toggle();

  // Validation logic
  bool _validateInputs() {
    bool isValid = true;

    // Full Name
    if (name.text.trim().isEmpty) {
      nameError.value = 'Full name is required';
      isValid = false;
    } else {
      nameError.value = '';
    }

    // Email
    if (email.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(email.text.trim())) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Phone
    if (phone.text.trim().isEmpty) {
      phoneError.value = 'Phone number is required';
      isValid = false;
    } else if (!RegExp(r'^[0-9]{7,15}$').hasMatch(phone.text.trim())) {
      phoneError.value = 'Enter a valid phone number';
      isValid = false;
    } else {
      phoneError.value = '';
    }

    // Password
    if (password.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (password.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    return isValid;
  }

  // Signup logic
  Future<void> signup() async {
    if (!_validateInputs()) return;

    isLoading.value = true;

    final url = Uri.parse('${AppSettings.baseUrl}users/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.text.trim(),
          'email': email.text.trim(),
          'phone': phone.text.trim(),
          'password': password.text,
          'role_id': 2,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 201 && body['status'] == true) {
        Get.offAllNamed('/login');
        final snackBarShow = Snackbar(
          title: 'Success',
          message: 'Account Created successfully...!',
          type: 'success',
        );
        snackBarShow.show();
      }
      else {
        final snackBarShow = Snackbar(
          title: 'Failed',
          message: body['error'] ,
          type: 'error',
        );
        snackBarShow.show();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.onClose();
  }
}
