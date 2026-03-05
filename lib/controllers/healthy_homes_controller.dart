import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../app_settings/settings.dart';
import '../models/housing_model.dart';
import '../screens/profile/change_password.dart';

class HealthyHomeController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final message = RxnString();
  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var territorialAuthority = <Area>[].obs;
  var apiStatisticalArea = <StatisticalArea>[].obs;
  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  var selectedOwned = ''.obs;
  var isLoading = false.obs;

  List<String> owned = ['Owned', 'Rent'];
  void selectTA(String? value) {
    selectedTA.value = value ?? '';
    if (value != null && value.isNotEmpty) {
      statisticalArea(value); // ✅ Fetch SA2 list for selected TA
    }
  }

  // Income Verification
  var incomeFilePath = ''.obs;
  var imageFilePath = ''.obs;

  // File picker for income
  Future<void> pickIncomeVerificationFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      incomeFilePath.value = result.files.single.path!;
    }
  }

  // File picker for image
  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  var selectedInspectionType = 'free'.obs;

  // Call this method on tap
  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
  }

  // Validate name and phone number inputs
  void validateFields() {
    // Trim whitespace and check if name is empty
    nameError.value = nameController.text.trim().isEmpty
        ? 'Name is required'
        : '';

    // Validate phone number using regex (only digits)
    phoneError.value =
        !RegExp(r'^[0-9]+$').hasMatch(phoneController.text.trim())
        ? 'Enter a valid phone number'
        : '';

    // Address
    addressError.value = addressController.text.trim().isEmpty
        ? 'Address required'
        : '';
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<bool> homeInspectionRequest() async {
    try {
      if (selectedSA2.value == null) {
        message.value = "Please Select the Statistical Area";
        return false;
      }

      if (incomeFilePath.value.isEmpty) {
        message.value = "Income certification Should not be Empty";
        return false;
      }

      if (imageFilePath.value.isEmpty) {
        message.value = "Image Should Not be Empty";
        return false;
      }

      if (addressController.text.isEmpty) {
        message.value = "Address Should Not be Empty";
        return false;
      }

      if (selectedOwned.value == "") {
        message.value = "Please Select the Ownership Type";
        return false;
      }

      if (selectedInspectionType.value == "") {
        message.value = "Please Choose Your Applying Type";
        return false;
      }
      final incomeFile = File(incomeFilePath.value);
      final imageFile = File(imageFilePath.value);

      final url = Uri.parse(
        '${AppSettings.baseUrl}housing/home-inspection-request',
      );
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});
      request.fields['address'] = addressController.text.toString();
      request.fields['s_area_id'] = selectedSA2.value!;
      request.fields['ownership_type'] = (selectedOwned.value == 'Owned' ? 1 : selectedOwned.value == 'Rent' ? 2 : 0).toString();
      request.fields['applying_for'] = (selectedInspectionType.value == 'discounted' ? 2 : selectedInspectionType.value == 'free' ? 1 : 0).toString();
      request.files.add(await http.MultipartFile.fromPath('income_verification_document', incomeFile.path,),);
      request.files.add(await http.MultipartFile.fromPath('upload_image', imageFile.path),);
      final response = await request.send();

      if (response.statusCode == 201) {
        addressController.text = "";
        selectedSA2.value = "";
        message.value = "Request Sent Successfully...!";
        return true;
      } else {
        message.value = "Request Not Sent Try Again ";
        return false;
      }
    } catch (e) {
      message.value = "Some thing went Wrong";
      return false;
    }
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
        territorialAuthority.value = data
            .map((item) => Area.fromJson(item))
            .toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> statisticalArea(String? id) async {
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
        apiStatisticalArea.value = dataList
            .map((item) => StatisticalArea.fromJson(item))
            .toList();
      }
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }
}
