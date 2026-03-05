import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../app_settings/settings.dart';
import '../models/housing_model.dart';
import '../screens/profile/change_password.dart';

class RequestTrustyCommunityController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;

  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  final message = RxnString();
  var selectedOwned = ''.obs;
  var isLoading = false.obs;
  var requestName = ''.obs;
  var requestId = 0.obs;

  // image   Verification

  var imageFilePath = ''.obs;
  var territorialAuthority = <Area>[].obs;
  var apiStatisticalArea = <StatisticalArea>[].obs;
  var apiRepairingIssue = <RepairingIssueType>[].obs;
  var apiPreferences = <TrustedRepairingIssueType>[].obs;

  // File picker for image
  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  /* Dropdown data */
  final List<String> issueTypes = [
    'Heating',
    'Plumbing',
    'Electrical',
    'Other',
  ];
  final List<String> urgencyLevels = ['Low', 'Medium', 'High'];
  final List<String> preferences = ['Female Tech', 'Male Tech'];
  final List<String> payment = ['Not Sure', 'cash'];

  /* Selected values */
  var selectedIssueType = ''.obs;
  var selectedUrgencyLevel = ''.obs;
  var selectedPreferences = ''.obs;
  var selectedPayment = ''.obs;

  /* Show description field when “Other” is picked */
  var showDescription = false.obs;

  /* === METHODS === */
  void selectIssueType(String? value) {
    selectedIssueType.value = value ?? '';
    showDescription.value = selectedIssueType.value == 'Other';
  }

  void selectUrgency(String? value) {
    selectedUrgencyLevel.value = value ?? '';
  }

  void selectPreferences(String? value) {
    selectedPreferences.value = value ?? '';
  }

  void selectPayment(String? value) {
    selectedPayment.value = value ?? '';
  }

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
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<bool> trustedHomeRepairingService() async {
    if (imageFilePath.value.isEmpty) {
      message.value = "Image Should Not be Empty";
      return false;
    }

    if (addressController.text.isEmpty) {
      message.value = "Address Should Not be Empty";
      return false;
    }

    if (selectedSA2.value == "") {
      message.value = "Please Select the Statistical Area";
      return false;
    }

    if (requestId.value == "") {
      message.value = "Please Select the Type os Issue";
      return false;
    }

    if (selectedUrgencyLevel.value == "") {
      message.value = "Please Select the Urgency Level";
      return false;
    }

    if (requestId.value == "") {
      message.value = "Please Select the Technician Preferences";
      return false;
    }

    if (selectedPayment.value == "") {
      message.value = "Please Select the Payment Method";
      return false;
    }

    final imageFile = File(imageFilePath.value);

    final url = Uri.parse(
      '${AppSettings.baseUrl}housing/trusted-home-repair-service',
    );
    final request = http.MultipartRequest('POST', url);
    //
    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});
    request.fields['address'] = addressController.text.toString();
    request.fields['s_area_id'] = selectedSA2.value ?? '';
    request.files.add(
      await http.MultipartFile.fromPath('upload_image', imageFile.path),
    );
    request.fields['issue_id'] = requestId.value.toString();
    request.fields['urgency_level'] =
        (selectedUrgencyLevel.value == 'High'
                ? 1
                : selectedUrgencyLevel.value == 'Medium'
                ? 2
                : selectedUrgencyLevel.value == 'Low'
                ? 3
                : 0)
            .toString();
    request.fields['preference_id'] = requestId.value.toString();
    request.fields['payment_method_id'] =
        (selectedPayment.value == 'Not Sure'
                ? 1
                : selectedPayment.value == 'cash'
                ? 2
                : 0)
            .toString();
    final response = await request.send();

    if (response.statusCode == 201) {
      addressController.text = "";
      message.value = "Request Sent Successfully...!";
      return true;
    } else {
      message.value = "Request Not Sent Try Again ";
      return false;
    }
    // try { }
    // catch(e){
    //   message.value = "Some thing went Wrong";
    //   return false;
    // }
  }

  Future<void> fetchTerritorialArea() async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}housing/territorial-area');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      final responseBody = json.decode(response.body);
      final data = responseBody['data'];

      if (data is List) {
        territorialAuthority.value =
            data.map((item) => Area.fromJson(item)).toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRepairingIssues() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}housing/home-repairing-issue',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      final responseBody = json.decode(response.body);
      final data = responseBody['data'];

      if (data is List) {
        apiRepairingIssue.value =
            data.map((item) => RepairingIssueType.fromJson(item)).toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> statisticalArea(int id) async {
    isLoading.value = true;
    selectedSA2.value = null;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}housing/statistical-area');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final List<dynamic> dataList = responseBody; // <- Update this
        apiStatisticalArea.value =
            dataList.map((item) => StatisticalArea.fromJson(item)).toList();
      }
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPreferences() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}housing/trusted-repairing-support',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      final responseBody = json.decode(response.body);
      final data = responseBody['data'];

      if (data is List) {
        apiPreferences.value =
            data
                .map((item) => TrustedRepairingIssueType.fromJson(item))
                .toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }
}
