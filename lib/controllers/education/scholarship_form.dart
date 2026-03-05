import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScholarshipFormController extends GetxController {
  var selectedTA = ''.obs;
  var selectedSA2 = RxnString();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final message = RxnString();
  var isLoading = false.obs;
  var imageFilePath = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  var identityFilePath = ''.obs;
  var transcriptFilePath = ''.obs;
  var enrollmentFilePath = ''.obs;
  var incomeFilePath = ''.obs;
  var statementFilePath = ''.obs;
  var cvFilePath = ''.obs;

  Future<void> pickImageFile(RxString target) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'xlsx', 'doc'],
    );

    if (result != null && result.files.single.path != null) {
      target.value = result.files.single.path!;
    } else {
      Get.snackbar(
        "Invalid File",
        "Only PDF, JPG, JPEG, PNG, XLSX, DOC are allowed",
      );
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

    if (identityFilePath.value.isEmpty) {
      message.value = "Please Upload Proof of Identity";
      return false;
    }

    if (transcriptFilePath.value.isEmpty) {
      message.value = "Please Upload Academic Transcript or NCEA Results";
      return false;
    }
    if (enrollmentFilePath.value.isEmpty) {
      message.value = "Please Upload Proof of Enrollment (or Offer Letter)";
      return false;
    }

    if (incomeFilePath.value.isEmpty) {
      message.value = "Please Upload Proof of Income";
      return false;
    }
    if (statementFilePath.value.isEmpty) {
      message.value = "Please Upload personal Statement or Cover Letter";
      return false;
    }
    if (cvFilePath.value.isEmpty) {
      message.value = "Please Upload Curriculum Vitae (CV)";
      return false;
    }

    final url = Uri.parse(
      '${AppSettings.baseUrl}education/apply-for-scholarship',
    );
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({'Authorization': 'Bearer ${box.read('token')}'});

    request.fields['address'] = addressController.text;
    request.fields['sa2_id'] = int.tryParse(selectedSA2.value ?? '').toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        'proof_of_identity',
        identityFilePath.value,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'academic_transcript',
        transcriptFilePath.value,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'proof_of_enrollment',
        enrollmentFilePath.value,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'proof_of_income',
        incomeFilePath.value,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'personal_statement',
        statementFilePath.value,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath('cv', cvFilePath.value),
    );
    final apiResponse = await request.send();
    final responseBody = await apiResponse.stream.bytesToString();
    print("📡 Status: ${apiResponse.statusCode}");
    print("📡 Response: $responseBody");
    if (apiResponse.statusCode == 201) {
      addressController.clear();
      selectedSA2.value = null;
      selectedTA.value = "";
      message.value = "Request Sent Successfully";
      return true;
    } else {
      message.value = "Request Not Sent";
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
