import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResumeTemplateController extends GetxController {
  var isLoading = false.obs;
  var category = <Map<String, dynamic>>[].obs;
  var selectedCategory = Rxn<Map<String, dynamic>>();
  var resume = <Map<String, dynamic>>[].obs;
  var allResumes = <Map<String, dynamic>>[].obs;
  Future<void> fetchClass() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${AppSettings.baseUrl}jobs/job-categories');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        log('categories: $data');
        category.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Jobs');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchResume({int? resumeId}) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/get-resume-template',
      );
      final requestBody = {"status": 2};
      if (resumeId != null) requestBody['job_title_id'] = resumeId;
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        log('Resume: $data');
        allResumes.value = List<Map<String, dynamic>>.from(
          data,
        ); // 👈 keep original
        resume.assignAll(allResumes); // initially show all
      } else {
        Get.snackbar('Error', 'Failed to Load Classes');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(int categoryId) {
    final filtered =
        allResumes
            .where((resume) => resume['job_title_id'] == categoryId)
            .toList();
    resume.assignAll(filtered);
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
      return false;
    } else {
      return true;
    }
  }

  Future<void> downloadResume(String filePath) async {
    try {
      String fixedPath = filePath.replaceFirst("upload/", "uploads/");
      final String baseFileUrl = AppSettings.baseUrl.replaceAll("/api/", "/");

      final url =
          fixedPath.startsWith("http") ? fixedPath : "$baseFileUrl$fixedPath";

      print("📂 Downloading from: $url");

      final dir = await getApplicationDocumentsDirectory();
      final savePath = "${dir.path}/${fixedPath.split('/').last}";

      await OpenFilex.open(savePath);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print('❌ Error: $e');
    }
  }
}
