
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../app_settings/settings.dart';
import '../main.dart';

class CommunityWasteSupportRequestController extends GetxController {
  // TextEditingControllers for name and phone input fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedInspectionType = 'free'.obs;
  var selectedType = 0.obs;
  final message = "".obs;
  var imageFilePath = ''.obs;

  Future<void> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Or restrict to pdf, images, etc.
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }

  void selectInspectionType(String type) {
    selectedInspectionType.value = type;
    if(type == 'Join Cleaning Group'){
      selectedType.value = 1;
    }else if(type == 'Request Waste Pickup'){
      selectedType.value = 3;
    }
    else{
      selectedType.value = 3;
    }
  }

  Future<bool> sendWasteSupportRequest() async {
    if (imageFilePath.value.isEmpty) {
      message.value = "Image Should Not be Empty";
      return false;
    }

    if(addressController.text.isEmpty){
      message.value = "Address Should Not be Empty";
      return false;
    }

    if(selectedSA2.value == ""){
      message.value = "Please Select the Statistical Area";
      return false;
    }

    final imageFile  = File(imageFilePath.value);
    final url = Uri.parse('${AppSettings.baseUrl}social/community-waste-support');
    final request = http.MultipartRequest('POST', url);
    //
    request.headers.addAll({
      'Authorization': 'Bearer ${box.read('token')}',
    });
    request.fields['address'] = addressController.text.toString();
    request.fields['sa2'] = selectedSA2.value ;
    request.fields['apply_for'] = (selectedType.value).toString();
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    final response = await request.send();
    if (response.statusCode == 201) {
      addressController.text = "";
      message.value = "Request Sent Successfully...!";
      return true;
    }
    else{
      message.value = "Request Not Sent Try Again ";
      return false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
