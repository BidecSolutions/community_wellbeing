import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../main.dart';

class ArticleController extends GetxController {
  // final selectedCategory = 'All'.obs;
  final RxInt selectedIndex = 0.obs;
  RxList<Map<String, dynamic>> tabs = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> articles = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filter = <Map<String, dynamic>>[].obs;

  Future<void> fetchArticles() async {
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}disability/get-all-articles',
      );
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];
        if (data is List) {
          articles.value =
              data.map<Map<String, dynamic>>((item) {
                return {
                  "id": item['id'],
                  "name": item['name'],
                  "title": item['abstraction'],
                  "image": item['image'],
                  "article_content": item['article_content'],
                  "category_id": item['category_id'],
                };
              }).toList();
          filterArticles(0);
        }
      }
    } catch (e) {
      e;
    }
  }

  void filterArticles(int? value) {
    selectedIndex.value = value ?? 0;
    if (selectedIndex.value == 0) {
      filter.assignAll(articles);
    } else {
      final filtered =
          articles.where((indexValue) {
            final categoryId = int.tryParse(
              indexValue['category_id'].toString(),
            );
            return categoryId == selectedIndex.value;
          }).toList();
      filter.assignAll(filtered);
    }
  }

  Future<void> fetchCategory() async {
    try {
      final url = Uri.parse('${AppSettings.baseUrl}disability/get-all-types');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];

        if (data is List) {
          tabs.value = [
            {"id": 0, "name": "All"},
            ...data.map<Map<String, dynamic>>((item) {
              return {"id": item['id'], "name": item['name']};
            }),
          ];
        }
      }
    } catch (e) {
      e;
    }
  }
}
