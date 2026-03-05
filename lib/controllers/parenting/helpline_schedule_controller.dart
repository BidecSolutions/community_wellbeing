import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../screens/profile/personal_info.dart';

class HelplineScheduleController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final helpForController = TextEditingController();
  final zipController = TextEditingController();
  var forHelpSelect = ''.obs;
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  final RxList<Map<String, dynamic>> forHelp = <Map<String, dynamic>>[].obs;
  var requestId = 0.obs;
  var requestName = ''.obs;
  final message = ''.obs;

  Future<void> getUserName() async {
    nameController.text = box.read('name');
    phoneController.text = box.read('phone');

    final url = Uri.parse('${AppSettings.baseUrl}parenting/for-help');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);
      forHelp.clear();
      final List<dynamic> data = apiResponse;
      forHelp.assignAll(
        data.map((item) => item as Map<String, dynamic>).toList(),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> submitEmergencyRequest() async {
    if (descriptionController.text.isEmpty) {
      message.value = "Please Insert Description";
      return false;
    }
    if (forHelpSelect.value == "") {
      message.value = "Please Select Help For";
      return false;
    }

    if (selectedTA.value == "") {
      message.value = "Please Select TA";
      return false;
    }
    if (requestId.value == 0) {
      message.value = "Please Select Your Request";
      return false;
    }
    if (selectedSA2.value == null || selectedSA2.value == 'null') {
      message.value = "Please Select SA2";
      return false;
    }

    if (addressController.text.isEmpty) {
      message.value = "Please Insert Address";
      return false;
    }
    final url = Uri.parse('${AppSettings.baseUrl}parenting/emergency-request');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "s_area_id": selectedSA2.value,
        "description": descriptionController.text,
        "help_for_id": requestId.value,
        "postal_code": 251914,
        "address": addressController.text,
      }),
    );
    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");
    if (response.statusCode == 201) {
      final apiResponse = jsonDecode(response.body);
      message.value = apiResponse['message'];
      descriptionController.text = "";
      forHelpSelect.value = "";
      selectedTA.value = "";
      addressController.text = "";
      return true;
    } else {
      message.value = "Request Not Sent..!";
      return false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
