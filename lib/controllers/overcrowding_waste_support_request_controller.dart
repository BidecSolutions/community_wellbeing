import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class OvercrowdingWasteSupportRequestController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final relationController = TextEditingController();
  final peopleController = TextEditingController();
  final bedroomsController = TextEditingController();
  final childrenElderlyController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  final relationError = ''.obs;
  final peopleError = ''.obs;
  final bedroomsError = ''.obs;
  final childrenError = ''.obs;

  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;

  List<String> ta = ['City A', 'City B', 'City C'];
  List<String> sa2 = ['Region X', 'Region Y', 'Region Z'];

  // Income Verification
  var imageFilePath = ''.obs;

  // File picker for image
  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  // applying for
  // Observable for selected option
  var selectedInspectionType = 'free'.obs;

  // Call this method on tap
  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
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

  /// Validate the four household-info fields
  void validateHouseholdInfo() {
    peopleError.value = peopleController.text.trim().isEmpty ? 'Required' : '';
    bedroomsError.value =
        bedroomsController.text.trim().isEmpty ? 'Required' : '';
    childrenError.value =
        childrenElderlyController.text.trim().isEmpty ? 'Required' : '';
    relationError.value =
        relationController.text.trim().isEmpty ? 'Required' : '';
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    peopleController.dispose();
    bedroomsController.dispose();
    childrenElderlyController.dispose();
    relationController.dispose();
    super.onClose();
  }
}
