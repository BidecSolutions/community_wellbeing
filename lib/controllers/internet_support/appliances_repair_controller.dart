import 'dart:io';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppliancesRepairController extends GetxController {
  var imageFilePath = ''.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var descriptionError = ''.obs;
  var requestName = ''.obs;
  var requestId = 0.obs;

  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedOWNED = ''.obs;
  var selectedRequest = RxnInt();
  final message = "".obs;
  var contactedType = RxnInt();
  var imageType = RxnInt();

  void selectInspectionType(int type) {
    contactedType.value = type;
  }

  void selectImageType(int type) {
    imageType.value = type;
  }

  Future<bool> sendRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter Your Address";
      return false;
    }
    if (selectedSA2.isEmpty) {
      message.value = "Please Select your Statistical Area 2";
      return false;
    }

    if (contactedType.value == null) {
      message.value = "Please Select Preference";
      return false;
    }

    final url = Uri.parse(
      '${AppSettings.baseUrl}internet-support/apply-for-repairing-request',
    );
    final request = http.MultipartRequest('POST', url);
    if (imageFilePath.value != "") {
      final imageFile = File(imageFilePath.value);
      request.files.add(
        await http.MultipartFile.fromPath(
          'appliance-repairing',
          imageFile.path,
        ),
      );
    }

    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});

    request.fields['sa2'] = selectedSA2.value ?? '';
    request.fields['address'] = addressController.text.toString();
    request.fields['repairing_cate_id'] = requestId.value.toString();
    request.fields['problem_description'] = descriptionController.text;
    request.fields['safe_preferences'] = contactedType.value.toString();
    final response = await request.send();
    if (response.statusCode == 201) {
      selectedSA2.value = "";
      addressController.text = "";
      requestId.value = 0;
      descriptionController.text = "";
      contactedType.value = null;
    }
    return true;
  }

  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }
}
