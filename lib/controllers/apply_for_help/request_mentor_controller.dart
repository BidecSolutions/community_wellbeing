import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';

class RequestMentorController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var descriptionError = ''.obs;

  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedOWNED = ''.obs;
  var selectedRequest = RxnInt();
  final message = "".obs;
  var selectedInspectionType = RxnInt();
  var requestId = 0.obs;
  var requestName = ''.obs;
  // Call this method on tap
  void selectInspectionType(int type) {
    selectedInspectionType.value = type;
  }

  // Validate name and phone number inputs
  void validateFields() {
    // Trim whitespace and check if name is empty
    nameError.value =
        nameController.text.trim().isEmpty ? 'Name is required' : '';

    // Validate phone number using regex (only digits)
    phoneError.value =
        !RegExp(r'^[0-9]+$').hasMatch(phoneController.text.trim())
            ? 'Enter a valid phone number'
            : '';

    // Address
    addressError.value =
        addressController.text.trim().isEmpty ? 'Address required' : '';
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<bool> sendRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter Your Address";
      return false;
    }
    if (selectedTA.isEmpty) {
      message.value = "Please Select your Territorial Area";
      return false;
    }
    if (selectedSA2.isEmpty) {
      message.value = "Please Select your Statistical Area 2";
      return false;
    }
    if (requestId.value == null) {
      message.value = "Please Select Request For";
      return false;
    }

    if (selectedInspectionType.value == null) {
      message.value = "Please Select Preference";
      return false;
    }

    if (descriptionController.text.isEmpty) {
      message.value = "Please Enter Description";
      return false;
    }

    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}apply-for-help/mentor-request',
      );
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({
          "home_address": addressController.text,
          "s_area_2": selectedSA2.value,
          "type_of_request": requestId.value,
          "preference": selectedInspectionType.value,
          "decription": descriptionController.text,
        }),
      );
      final apiResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        message.value = apiResponse['message'];
        addressController.clear();
        descriptionController.clear();
        selectedTA.value = "";
      }
      return true;
    } catch (e) {
      message.value = "Request Not Sent";
      return false;
    }
  }

  Future<void> fillData() async {
    phoneController.text = box.read('phone');
    nameController.text = box.read('name');
  }
}
