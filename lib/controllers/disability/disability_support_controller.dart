import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestSupportController extends GetxController {
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
  final descriptionController = TextEditingController();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  var descriptionError = ''.obs;

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

    if (selectedDate.value == null) {
      message.value = "Please Select Preferred Date";
      return false;
    }

    if (selectedTime.value == null) {
      message.value = "Please Select Preferred Time";
      return false;
    }

    if (descriptionController.text.isEmpty) {
      message.value = "Please Enter Description";
      return false;
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    final time = selectedTime.value!;
    String formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final requestBody = {
      "sa2": int.tryParse(selectedSA2.value ?? ''),
      "address": addressController.text,
      "cate_id": requestId.value,
      "p_date": formattedDate,
      "p_time": formattedTime,
      "note": descriptionController.text
    };
    final url = Uri.parse('${AppSettings.baseUrl}disability/request-support-from-community');
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
      addressController.text = "";
      requestName.value = "Select Type";
      requestId.value = 0;
      selectedType.value = 0;
      selectedInspectionType.value = "free";
      selectedDate.value = null;
      selectedTime.value = null;
      selectedSA2.value = null;
      selectedTA.value = "";
      descriptionController.text = "";
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
