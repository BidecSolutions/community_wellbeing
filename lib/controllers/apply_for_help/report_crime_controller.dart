import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../screens/profile/change_password.dart';

class ReportCrimeController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final crimeAddressController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var crimeAddressError = ''.obs;
  var descriptionError = ''.obs;
  final userName = ''.obs;
  var requestId = 0.obs;
  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedCTA = ''.obs;
  var selectedCSA2 = ''.obs;
  var selectedCrime = RxnInt();
  final message = ''.obs;

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
    // Address
    crimeAddressError.value =
        crimeAddressController.text.trim().isEmpty
            ? 'Crime Address required'
            : '';

    // description
    descriptionError.value =
        descriptionController.text.trim().isEmpty
            ? 'Fill out crime you see'
            : '';
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    crimeAddressController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<bool> sendRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter Your Address";
      return false;
    }
    if (selectedTA.value == '') {
      message.value = "Please Select your Territorial Area";
      return false;
    }
    if (selectedSA2.value == '') {
      message.value = "Please Select your Statistical Area 2";
      return false;
    }
    if (requestId.value == 0) {
      message.value = "Please Select Type Of Crime";
      return false;
    }
    if (crimeAddressController.text.isEmpty) {
      message.value = "Please Enter Crime Address";
      return false;
    }
    if (selectedCTA.value == '') {
      message.value = "Please Select crime Territorial Area";
      return false;
    }
    if (selectedCSA2.value == '') {
      message.value = "Please Select crime Statistical Area 2";
      return false;
    }

    if (descriptionController.text.isEmpty) {
      message.value = "Please Enter Crime Description";
      return false;
    }

    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}apply-for-help/register-crime',
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
          "type_of_crime": requestId.value,
          "crime_address": crimeAddressController.text,
          "crime_s_area_2": selectedCSA2.value,
          "crime_description": descriptionController.text,
        }),
      );
      final apiResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        message.value = apiResponse['message'];
        addressController.clear();
        descriptionController.clear();
        selectedTA.value = "";
        selectedCTA.value = "";
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
