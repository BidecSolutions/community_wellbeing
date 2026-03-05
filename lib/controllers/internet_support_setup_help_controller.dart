import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetSupportSetupHelpController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;

  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;

  List<String> ta = ['City A', 'City B', 'City C'];
  List<String> sa2 = ['Region X', 'Region Y', 'Region Z'];

  // applying for
  // Observable for selected option
  var selectedInspectionType = 'free'.obs;

  // Call this method on tap
  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
  }

  // Checkboxes for bullet points
  RxBool isPointOneChecked = false.obs;
  RxBool isPointTwoChecked = false.obs;

  void togglePointOne(bool? value) {
    isPointOneChecked.value = value ?? false;
  }

  void togglePointTwo(bool? value) {
    isPointTwoChecked.value = value ?? false;
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
    super.onClose();
  }
}
