import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../app_settings/settings.dart';
import '../../main.dart';

class CommunityNavigatorController extends GetxController {
  final int? navigatorId = Get.arguments;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final message = RxnString();
  var isLoading = false.obs;

  final addressController = TextEditingController();
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  var offerName = ''.obs;
  var offerId = 0.obs;
  final selectedType = 0.obs;
  var selectedInspectionType = 'free'.obs;
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

  Future<bool> sendRequestNavigator() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter the Address";
      return false;
    }

    if (selectedSA2.value == null) {
      message.value = "Please Select SA2";
      return false;
    }

    if (offerId.value == 0) {
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
      "purpose_id": offerId.value,
      "visit_type": selectedType.value,
      "navigator_id": navigatorId,
      "preferred_date": formattedDate,
      "preferred_time": formattedTime,
    };
    final url = Uri.parse(
      '${AppSettings.baseUrl}social/community-navigator-request',
    );
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
      offerName.value = "Select Housing Support";
      offerId.value = 0;
      selectedType.value = 0;
      selectedInspectionType.value = "free";
      selectedDate.value = null;
      selectedTime.value = null;
      selectedSA2.value = null;
      selectedTA.value = "";
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
    super.onClose();
  }
}
