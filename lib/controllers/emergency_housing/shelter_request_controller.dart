import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';


class ShelterRequestController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final noOfPeopleController = TextEditingController();
  final descriptionController = TextEditingController();



  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var noOfPeopleError = ''.obs;
  var descriptionError = ''.obs;
  final message = ''.obs;

  final shelterId = 0.obs;

  // applying for
  // Observable for selected option
  var selectedInspectionType = 'free'.obs;

  // Call this method on tap
  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
  }



  Future<void> fillData({required int id}) async{
    nameController.text = box.read('name');
    phoneController.text = box.read('phone');
    shelterId.value = id;
  }

  Future<bool> sendRequest() async{
    if (noOfPeopleController.text.isEmpty) {
      message.value = 'Please enter no of peoples';
      return false;
    }
    if (descriptionController.text.isEmpty) {
      message.value = 'Please Enter Note';
      return false;
    }

    final url = Uri.parse('${AppSettings.baseUrl}shelters/shelter-booking');
    final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
          "shelter_id":int.parse(shelterId.toString()),
          "no_of_people":int.tryParse(noOfPeopleController.text) ?? 0,
          "note":descriptionController.text
      }),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 201) {
      message.value = result['message'].toString() ;

      noOfPeopleController.clear();
      descriptionController.clear();
      return true;
    }
    else {
      message.value = result['message'].toString() ;
      return false;
    }
  }

  void validateFields() {

    nameError.value =
    nameController.text.trim().isEmpty ? 'Name is required' : '';

    // Validate phone number using regex (only digits)
    phoneError.value =
    !RegExp(r'^[0-9]+$').hasMatch(phoneController.text.trim())
        ? 'Enter a valid phone number'
        : '';

    // Address
    noOfPeopleError.value =
    noOfPeopleController.text.trim().isEmpty ? 'No of People required' : '';
  }



  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    noOfPeopleController.dispose();
    super.onClose();
  }
}
