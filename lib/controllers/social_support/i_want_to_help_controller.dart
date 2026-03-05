import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';

class IWantToHelpController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final offerController = TextEditingController();
  final itemNameController = TextEditingController();
  var requestName = ''.obs;
  var requestId = 0.obs;
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();
  final message = RxnString();
  var isLoading = false.obs;
  var imageFilePath = ''.obs;
  final selectedType = 0.obs;
  final toggleValue = false.obs;

  List<int> sizes = [1, 2, 3];
  var selectedSize = 0.obs;

  final List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var selectedQuantity = 0.obs;

  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  Future<bool> helpRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Address Should Not be Empty";
      return false;
    }

    if (selectedSA2.value == null) {
      message.value = "Please Select the Statistical Area";
      return false;
    }
    if (itemNameController.text.isEmpty) {
      message.value = "Please Enter Item Name";
      return false;
    }
    if (requestId.value == 0) {
      message.value = "Please Select offer";
      return false;
    }

    if (selectedSize.value == 0) {
      message.value = "Please Select Size";
      return false;
    }

    if (selectedQuantity.value == 0) {
      message.value = "Please Select Quantity";
      return false;
    }

    if (imageFilePath.value.isEmpty) {
      message.value = "Please Select Image";
      return false;
    }

    final content = toggleValue.value == true ? 1 : 2;
    final imageFile = File(imageFilePath.value);
    final url = Uri.parse('${AppSettings.baseUrl}social/want-to-help-request');
    final request = http.MultipartRequest('POST', url);
    //
    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});

    request.fields['address'] = addressController.text.toString();
    request.fields['sa2'] = selectedSA2.value ?? '';
    request.fields['item_name'] = itemNameController.text.toString();
    request.fields['offer_id'] = (requestId.value).toString();
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    request.fields['size'] = selectedSize.toString();
    request.fields['quantity'] = selectedQuantity.toString();
    request.fields['description'] = 'description'.toString();
    request.fields['show_detail'] = content.toString();
    final response = await request.send();

    if (response.statusCode == 201) {
      addressController.text = "";
      message.value = "Request Sent Successfully...!";

      addressController.text = "";
      requestName.value = "Select Offers";
      requestId.value = 0;
      selectedType.value = 0;
      selectedSA2.value = null;
      selectedTA.value = "";
      imageFilePath.value == "";
      toggleValue.value == false;
      return true;
    } else {
      message.value = "Request Not Sent Try Again ";
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
