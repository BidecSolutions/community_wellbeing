import 'dart:convert';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/app_categories_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppCategoriesController extends GetxController {
  var categories = <AppCategoriesModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchModules();
  }

  void fetchModules() async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}get-app-categories');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({'status': 1}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          final List<dynamic> jsonList = data['data'];
          categories.value = jsonList.map((e) => AppCategoriesModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }
}
