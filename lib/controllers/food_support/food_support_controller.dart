import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';

class FoodSupportController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  RxList<Map<String, dynamic>> foodBankList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> slotsList = <Map<String, dynamic>>[].obs;
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  var requestName = ''.obs;
  var requestId = 0.obs;
  final List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var selectedQuantity = 0.obs;
  var selectedInspectionType = 'free'.obs;
  final selectedType = 0.obs;
  final message = RxnString();
  var address = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  void setLocation(double lat, double long) {
    latitude.value = lat;
    longitude.value = long;
  }

  void updateAddress(String value) {
    address.value = value;
  }

  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
    if (type == 'Delivery') {
      selectedType.value = 1;
    } else {
      selectedType.value = 2;
    }
  }

  Future<bool> sendFoodSupportRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Address Should Not Empty";
      return false;
    }
    if (selectedSA2.value == null) {
      message.value = "Statistical Area Should not Empty";
      return false;
    }
    if (requestId.value == 0) {
      message.value = "Please Select the Who is this for ?";
      return false;
    }
    if (selectedQuantity.value == 0) {
      message.value = "Please Select the How many Persons?";
      return false;
    }
    if (selectedType.value == 0) {
      message.value = "Please Select the Proceed Type";
      return false;
    }
    try {
      final requestBody = {
        "address": addressController.text,
        "sa2": int.tryParse(selectedSA2.value ?? ''),
        "parcel_cate_id": requestId.value,
        "total_person": selectedQuantity.value,
        "type": selectedType.value,
        "description": descriptionController.text,
      };
      final url = Uri.parse(
        '${AppSettings.baseUrl}food-support/food-support-request',
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
        descriptionController.text = "";
        requestName.value = "Select Parcel For";
        requestId.value = 0;
        selectedType.value = 0;
        selectedInspectionType.value = "free";
        selectedSA2.value = null;
        selectedTA.value = "";
        selectedQuantity.value = 0;
        message.value = apiResponse['message'].toString();
        return true;
      } else {
        message.value = apiResponse['message'].toString();
        return false;
      }
    } catch (e) {
      message.value = e.toString();
      return false;
    }
  }

  Future<void> fetchFoodBank() async {
    final url = Uri.parse(
      '${AppSettings.baseUrl}food-support/food-support-food-bank',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"status": 1}),
    );
    final apiResponse = jsonDecode(response.body);
    final data = apiResponse['data'];
    if (data is List) {
      foodBankList.value =
          data.map<Map<String, dynamic>>((item) {
            return {
              "name": item['name'],
              "address": item['address'],
              "service": item['services'],
              "contact": item['contact'],
              "latitude": item['latitude'],
              "longitude": item['longitude'],
              "slots": item['slots'],
            };
          }).toList();
    }
  }
}
