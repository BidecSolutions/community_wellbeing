import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class WinterWarmthEnergySupportController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final peopleLiveController = TextEditingController();
  final childrenController = TextEditingController();

  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  final peopleLiveError = ''.obs;
  final childrenError = ''.obs;

  // Dropdown values
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedRequest = ''.obs;

  List<String> ta = ['City A', 'City B', 'City C'];
  List<String> sa2 = ['Region X', 'Region Y', 'Region Z'];
  List<String> request = ['Heaters', 'Blankets', 'Dehumidifiers'];

  // image   Verification

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

  // Validate name and phone number inputs
  void validateFields() {
    // Trim whitespace and check if name is empty
    nameError.value =
        nameController.text.trim().isEmpty ? 'Name is required' : '';
    // Trim whitespace and check if People Live is empty
    peopleLiveError.value =
        peopleLiveController.text.trim().isEmpty
            ? 'People Live is required'
            : '';

    // Trim whitespace and check if No Of children is empty
    childrenError.value =
        childrenController.text.trim().isEmpty
            ? 'No of Children is required'
            : '';

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
    peopleLiveController.dispose();
    childrenController.dispose();
    super.onClose();
  }
}
