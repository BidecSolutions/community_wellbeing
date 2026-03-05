import 'dart:io';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DonateAppliancesController extends GetxController {
  var imageFilePath = ''.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final productNameController = TextEditingController();
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var descriptionError = ''.obs;
  var requestName = ''.obs;
  var requestId = 0.obs;
  var selectedQuantity = 0.obs;
  var offerName = ''.obs;
  var offerId = 0.obs;
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedOWNED = ''.obs;
  var selectedRequest = RxnInt();
  final message = "".obs;
  var contactedType = RxnInt();
  var collectedType = RxnInt();
  var imageType = RxnInt();
  final List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  void selectInspectionType(int type) {
    contactedType.value = type;
  }

  void selectCollectedType(int type) {
    collectedType.value = type;
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

    if (productNameController.text.isEmpty) {
      message.value = "Please Enter Product Name";
      return false;
    }

    if (offerId == 0) {
      message.value = "Please Select The Category";
      return false;
    }

    if (contactedType.value == null) {
      message.value = "Please Condition of Appliance";
      return false;
    }
    if (collectedType.value == null) {
      message.value = "Please Select how to Collect?";
      return false;
    }
    if (imageFilePath.value == null) {
      message.value = "Please upload an image";
      return false;
    }

    if (selectedQuantity.value == 0) {
      message.value = "Please Select the How many Persons?";
      return false;
    }
    if (imageFilePath.value == "") {
      message.value = "Please Select Image";
      return false;
    }

    final url = Uri.parse(
      '${AppSettings.baseUrl}pre-loved/appliance-donation-request',
    );
    final request = http.MultipartRequest('POST', url);

    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});
    final imageFile = File(imageFilePath.value);

    request.fields['sa2'] = selectedSA2.value ?? '';
    request.fields['address'] = addressController.text.toString();
    request.fields['name'] = productNameController.text;
    request.fields['category_id'] = offerId.value.toString();
    request.files.add(
      await http.MultipartFile.fromPath('appliance-donation', imageFile.path),
    );
    request.fields['description'] = descriptionController.text.toString();
    request.fields['condition_type'] = contactedType.value.toString();
    request.fields['collected_type'] = collectedType.value.toString();
    request.fields['quantity'] = selectedQuantity.value.toString();
    final response = await request.send();
    if (response.statusCode == 201) {
      selectedSA2.value = "";
      addressController.text = "";
      productNameController.text;
      offerId.value = 0;
      descriptionController.text = "";
      contactedType.value = null;
      collectedType.value = null;
      selectedQuantity.value = 0;
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
