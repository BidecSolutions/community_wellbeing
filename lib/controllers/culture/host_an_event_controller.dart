import 'dart:io';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HostAnEventController extends GetxController {
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  var requestName = ''.obs;
  var requestId = 0.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final offerController = TextEditingController();
  final message = RxnString();
  var isLoading = false.obs;
  var selectedInspectionType = 'free'.obs;
  final selectedType = 0.obs;
  var imageFilePath = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
    if (type == 'Location') {
      selectedType.value = 1;
    } else {
      selectedType.value = 2;
    }
  }

  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  Future<bool> sendRequestHostEvent() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter the Address";
      return false;
    }

    if (selectedSA2.value == null) {
      message.value = "Please Select SA2";
      return false;
    }

    if (requestId.value == 0) {
      message.value = "Please Select Your Event Type";
      return false;
    }

    if (selectedType.value == 0) {
      message.value = "Please Select Visit Type";
      return false;
    }

    if (selectedDate.value == null) {
      message.value = "Please Select Preferred Date";
      return false;
    }
    if (selectedTime.value == null) {
      message.value = "Please Select Preferred Time";
      return false;
    }
    if (imageFilePath.value.isEmpty) {
      message.value = "Please Upload Image";
      return false;
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    final time = selectedTime.value!;
    String formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    final imageFile = File(imageFilePath.value);

    final url = Uri.parse('${AppSettings.baseUrl}culture/event-host-request');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});
    request.fields['address'] = addressController.text.toString();
    request.fields['sa2'] = int.tryParse(selectedSA2.value ?? '').toString();
    request.fields['event_type_id'] = requestId.value.toString();
    request.fields['hosted_type'] = selectedType.value.toString();
    request.fields['preferred_date'] = formattedDate.toString();
    request.fields['preferred_time'] = formattedTime.toString();
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    final apiResponse = await request.send();
    if (apiResponse.statusCode == 201) {
      addressController.text = "";
      requestName.value = "Select Event Type";
      requestId.value = 0;
      selectedType.value = 0;
      selectedInspectionType.value = "free";
      selectedDate.value = null;
      selectedTime.value = null;
      selectedSA2.value = null;
      selectedTA.value = "";
      message.value = "Request Send Successfully";
      return true;
    } else {
      message.value = "Request Not Send";
      return false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    offerController.dispose();
    super.onClose();
  }
}
