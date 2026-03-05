import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class BookASetupVisitController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

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
  var contactedType = RxnInt();
  var imageType = RxnInt();

  void selectInspectionType(int type) {
    contactedType.value = type;
  }

  void selectImageType(int type) {
    imageType.value = type;
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
    // if (selectedRequest.value == null) {
    //   message.value = "Please Select Request For";
    //   return false;
    // }

    if (contactedType.value == null) {
      message.value = "Please Select Preference";
      return false;
    }

    if (descriptionController.text.isEmpty) {
      message.value = "Please Enter Description";
      return false;
    }

    final url = Uri.parse(
      '${AppSettings.baseUrl}justice/support-rebuild-foam-request',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "address": addressController.text,
        "sa2": selectedSA2.value ?? '',
        "category_id": selectedRequest.value ?? 0,
        "contact_type": contactedType.value ?? 0,
        "description": descriptionController.text,
      }),
    );
    final apiResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      message.value = apiResponse['message'];
      addressController.clear();
      descriptionController.clear();
      selectedTA.value = "";
      contactedType.value = null;
      // selectedRequest.value = null;
    }
    return true;
  }
}
