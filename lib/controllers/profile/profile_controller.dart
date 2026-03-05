import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app_settings/settings.dart';
import '../../screens/widgets/snack_bar.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final message = "".obs;
  var imageFilePath = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final imagePath = ''.obs;

  Future<void>  pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      imageFilePath.value = result.files.single.path!;
    }
  }
  Future<void> pickImage({required ImageSource source}) async {
    PermissionStatus permissionStatus;

    if (source == ImageSource.camera) {
      permissionStatus = await Permission.camera.request();
    } else {
      permissionStatus = await Permission.photos.request();
    }

    if (permissionStatus.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        imageFilePath.value = pickedFile.path; // set path for upload
        final success = await changeProfileImage(); // upload immediately
        if (success) {
          Get.snackbar("Success", "Profile image updated successfully");
        }
      } else {
        Get.snackbar("Cancelled", "No image selected.");
      }
    } else {
      Get.snackbar("Permission Denied", "Please grant permission to access ${source == ImageSource.camera ? 'camera' : 'media'}.");
    }
  }
  Future<bool> deleteMyProfile() async{
    final id = box.read('user_id');
    final url = Uri.parse('${AppSettings.baseUrl}users/delete-my-profile');
    final Map<String, dynamic> body = {};
    body['id'] = id;
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(body));

    if (response.statusCode == 201) {
      return true;
    }
    else{
      return false;
    }
  }
  Future<String> getFingerprint() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String raw = '';

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      // Corrected: Access androidId via info.id
      raw = '${info.model}-${info.id}-${info.device}';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      raw = '${info.name}-${info.identifierForVendor}-${info.systemVersion}';
    }

    final package = await PackageInfo.fromPlatform();
    raw += '-${package.packageName}';

    return sha256.convert(utf8.encode(raw)).toString();
  }
  Future<bool> changeProfileImage() async {
    final url = Uri.parse('${AppSettings.baseUrl}users/change-profile');
      try {
        final request = http.MultipartRequest('POST', url);
        request.headers.addAll({
          'Authorization': 'Bearer ${box.read('token')}',
        });
        final file = await http.MultipartFile.fromPath('upload_image', imageFilePath.value);
         request.files.add(file);

         final response = await request.send();
         if (response.statusCode == 201) {
           final responseBody = await response.stream.bytesToString();
            final data = jsonDecode(responseBody);
           message.value = data['message'];
           imagePath.value = data['data'][0]['image'];
           imageFilePath.value = "";
           box.remove('image');
            await box.write('image',data['data'][0]['image']);
            return true;
         }
         else{
           message.value = "Profile Not Changed";
           return false;
         }
      }
      catch (e) {
        message.value = "Request Not Send";
        return false;
    }
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final hniController = TextEditingController();


  // Observable variables to hold error messages for validation
  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var emailError = ''.obs;
  var dobError = ''.obs;
  var hniError = ''.obs;

  // Validate name and phone number inputs
  void validateFields() {
    // Trim whitespace and check if name is empty
    nameError.value = nameController.text
        .trim()
        .isEmpty
        ? 'Name is required'
        : '';

    // Validate phone number using regex (only digits)
    phoneError.value = phoneController.text.trim().isEmpty
        ? 'Phone is required'
        : !RegExp(r'^[0-9]+$').hasMatch(phoneController.text.trim())
        ? 'Enter a valid phone number'
        : '';

// address inputs

    // Trim whitespace and check if name is empty
    addressError.value = addressController.text
        .trim()
        .isEmpty
        ? 'address is required'
        : '';

// Email validation

    String email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!GetUtils.isEmail(email)) {
      // Using GetX utility for email format check
      emailError.value = 'Enter a valid email address';
    } else {
      emailError.value = '';
    }

    // dob input
    // Trim whitespace and check if name is empty
    dobError.value = dobController.text
        .trim()
        .isEmpty
        ? 'Date of Birth is required'
        : '';

    // hni input
    // Trim whitespace and check if name is empty
    hniError.value = hniController.text
        .trim()
        .isEmpty
        ? 'HNI is required'
        : '';
  }

  // API call to update user
  Future<void> updateUserProfile() async {
    validateFields();

    if (nameError.isNotEmpty ||
        phoneError.isNotEmpty ||
        addressError.isNotEmpty ||
        emailError.isNotEmpty ||
        dobError.isNotEmpty ||
        hniError.isNotEmpty) {
      return;
    }

    final token = box.read('token');
    final id = box.read('user_id');

    final url = Uri.parse('${AppSettings.baseUrl}users/updateUser');

    final payload = {
      "id": id ?? 0,
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "dob": dobController.text.trim(),
      "hin": hniController.text.trim(),
      "address": addressController.text.trim(),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        final snackBarShow = Snackbar(
          title: 'Success',
          message: 'Account Updated successfully...!',
          type: 'success',
        );
        snackBarShow.show();
        box.write('name', nameController.text.trim());
        box.write('email', emailController.text.trim());
        box.write('phone', phoneController.text.trim());
        box.write('address', addressController.text.trim());
        box.write('dob', dobController.text.trim());
        box.write('hin', hniController.text.trim());

        // Reload controllers to reflect new data in the view
        loadUserDataFromStorage();

      } else {
        final snackBarShow = Snackbar(
          title: 'Failed',
          message: responseData['error'] ,
          type: 'error',
        );
        snackBarShow.show();

      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    dobController.dispose();
    hniController.dispose();
    super.onClose();
  }
  void loadUserDataFromStorage() {
    nameController.text = box.read('name') ?? '';
    emailController.text = box.read('email') ?? '';
    phoneController.text = box.read('phone') ?? '';
    addressController.text = box.read('address') ?? '';
    dobController.text = box.read('dob') ?? '';
    hniController.text = box.read('hin') ?? '';
  }


  @override
  void onInit() {
    super.onInit();
    loadUserDataFromStorage();
    imagePath.value = box.read('image') ?? '';
  }

}
