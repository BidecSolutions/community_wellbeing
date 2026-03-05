import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';

class ChangePasswordController extends GetxController {
  //--- form work --
  // TextEditingControllers for name and phone input fields
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final message = "".obs;
  // Observable variables to hold error messages for validation
  final oldPassError = ''.obs;
  final newPassError = ''.obs;
  var confirmPassError = ''.obs;

  void validateFields() {
    oldPassError.value = oldPassController.text.trim().isEmpty ? 'Old Password  is required' : '';
    newPassError.value = newPassController.text.trim().isEmpty ? 'New Password is required' : '';
    confirmPassError.value = confirmPassController.text.trim().isEmpty ? 'Confirm Password is required' : '';
  }

  @override
  void onClose() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();

    super.onClose();
  }

  Future<bool> changePassword() async{
    validateFields();
    if(oldPassController.text.isNotEmpty && newPassController.text.isNotEmpty && confirmPassController.text.isNotEmpty){
        final url = Uri.parse('${AppSettings.baseUrl}auth/change-password');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: json.encode({
            "oldPassword":oldPassController.text,
            "confirmPassword":confirmPassController.text,
            "newPassword":newPassController.text
          }),
        );
        print('Response: ${response.statusCode} - ${response.body}');
        print('Token: ${box.read('token')}');
        print('Sending: old=${oldPassController.text.trim()}');
        final apiResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
            message.value = apiResponse['message'] + "\n Do you Want to Logout ? ";
            oldPassController.text = "";
            confirmPassController.text = "";
            newPassController.text = "";
            return true;
        }
        else {
          message.value = apiResponse['message'];
          return false;
        }
    }
    else{
       message.value = "Fill out All Fields";
       return false;
    }
  }
}
