import 'dart:convert';
import 'dart:developer';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/app_categories_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoryController extends GetxController {
  var allTabs = <AllTabModel>[].obs;
  var isLoading = false.obs;
  RxInt selectedCategory = 0.obs;
  var foamData = {}.obs;
  var requests = <Map<String, dynamic>>[].obs;
  final categoryName = "".obs;

  Future<void> fetchModules(int cateID, String? cateName) async {
    isLoading.value = true;
    selectedCategory.value = 0;
    final url = Uri.parse('${AppSettings.baseUrl}registry/get-tabs');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"cateID": cateID}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data is List) {
        allTabs.value = data.map((e) => AllTabModel.fromJson(e)).toList();
        if (allTabs.isNotEmpty) {
          selectedCategory.value = allTabs.first.id;
          log('Calling fetchFoam for id: ${allTabs.first.id}');
          await fetchFoam(allTabs.first.id);
          isLoading.value = false;
          categoryName.value = cateName.toString();
        }
      }
    }
  }

  Future<void> fetchFoam(int id) async {
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}registry/fetchFoam');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"id": id}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      print(data);
      // for (var lister in data['']) {
      //   print(lister);
      // }
      if (data is Map && data["details"] != null) {
        final details = data["details"];

        foamData.clear();
        foamData.value = {
          "id": details["id"] ?? 0,
          "tab_id": details["tab_id"] ?? 0,
          "index_name": details["index_name"] ?? '',
          "is_category": details["is_category"] ?? 0,
          "is_selected": details["is_selected"] ?? 0,
          "is_extra_selected": details["is_extra_selected"] ?? 0,
          "is_preference_date_time": details["is_preference_date_time"] ?? 0,
          "is_person_name": details["is_person_name"] ?? 0,
          "is_image": details["is_image"] ?? 0,
          "is_verification_document": details["is_verification_document"] ?? 0,
          "is_type": details["is_type"] ?? 0,
          "is_extra_address": details["is_extra_address"] ?? 0,
          "is_extra_sa2": details["is_extra_sa2"] ?? 0,
          "is_description_box": details["is_description_box"] ?? 0,
          "is_size": details["is_size"] ?? 0,
          "is_item_name": details["is_item_name"] ?? 0,
          "is_quantity": details["is_quantity"] ?? 0,
          "status": details["status"] ?? 0,
        };
      }
      final requestList = data["request"];
      requests.clear();
      if (requestList != null && requestList is List) {
        requests.value = List<Map<String, dynamic>>.from(requestList);
      } else {
        requests.value = [];
      }
    }
  }

  void selectCategory({required int categoryId}) {
    selectedCategory.value = categoryId;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['cateID'] != null) {
      int cateID = args['cateID'];
      String cateName = args['cateName'];
      fetchModules(cateID, cateName);
    }
  }

  var contactData = <Map<String, dynamic>>[].obs;
}
