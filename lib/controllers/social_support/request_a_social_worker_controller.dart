import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../app_settings/settings.dart';
import '../../main.dart';

class RequestASocialWorkerController extends GetxController {
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  var requestName = ''.obs;
  var requestId = 0.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final offerController = TextEditingController();
  final message = RxnString();
  var isLoading = false.obs;
  var selectedInspectionType = 'free'.obs;
  final selectedType = 0.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
    if (type == 'In Home') {
      selectedType.value = 1;
    } else {
      selectedType.value = 2;
    }
  }

  Future<bool> sendRequestSocialWorker() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter the Address";
      return false;
    }

    if (selectedSA2.value == null) {
      message.value = "Please Select SA2";
      return false;
    }

    if (requestId.value == 0) {
      message.value = "Please Select Your Request";
      return false;
    }

    if (selectedType.value == 0) {
      message.value = "Please Select Visit Type";
      return false;
    }

    if (selectedDate.value == null) {
      message.value = "Please Select Preferred Date";
      return false;
    }

    if (selectedTime.value == null) {
      message.value = "Please Select Preferred Time";
      return false;
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    final time = selectedTime.value!;
    String formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    final requestBody = {
      "address": addressController.text,
      "sa2": int.tryParse(selectedSA2.value ?? ''),
      "category_id": requestId.value,
      "visit_type": selectedType.value,
      "request_date": formattedDate,
      "request_time": formattedTime,
    };

    final url = Uri.parse('${AppSettings.baseUrl}social/social-worker-request');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode(requestBody),
    );

    final apiResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // ✅ Clear all fields including SA2 and TA after success
      addressController.clear();
      nameController.clear();
      phoneController.clear();
      offerController.clear();
      selectedSA2.value = null;
      selectedTA.value = "";
      selectedDate.value = null;
      selectedTime.value = null;
      requestName.value = "Select Housing Support";
      requestId.value = 0;
      selectedType.value = 0;
      selectedInspectionType.value = "free";

      message.value = apiResponse['message'].toString();
      return true;
    } else {
      message.value = apiResponse['message'].toString();
      return false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    offerController.dispose();
    super.onClose();
  }
}
