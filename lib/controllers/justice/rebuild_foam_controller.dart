import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';

class RebuildFoamController extends GetxController {
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
  final requestName = ''.obs;
  var requestId = 0.obs;

  void selectInspectionType(int type) {
    contactedType.value = type;
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
        "sa2": selectedSA2.value,
        "category_id": requestId.value,
        "contact_type": contactedType.value,
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
      selectedRequest.value = null;
    }
    return true;
    // try{}catch(e){
    //   message.value = "Request Not Sent";
    //   return false;
    // }
  }
}
