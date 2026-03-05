import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../app_settings/settings.dart';
import '../controllers/profile/test.dart';
import '../models/housing_model.dart';

class TerritorialAreaClass {
  var territorialAuthority = <Area>[].obs;
  var apiStatisticalArea = <StatisticalArea>[].obs;
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final userName = ''.obs;
  var requestId = 0.obs;
  var isLoading = false.obs;

  final RxList<Map<String, dynamic>> requestCat = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> allCrimes = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> crimeSa = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> requestTypes =
      <Map<String, dynamic>>[].obs;
  Future<void> fetchTerritorialAreas() async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}housing/territorial-area');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      final responseBody = json.decode(response.body);
      final data = responseBody['data'];

      if (data is List) {
        territorialAuthority.value =
            data.map((item) => Area.fromJson(item)).toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> statisticalArea({required int id, String? crime}) async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}housing/statistical-area');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"id": id}),
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);

        if (crime != null && crime.isNotEmpty) {
          crimeSa.clear();
          final List<dynamic> data = responseBody;
          crimeSa.assignAll(
            data.map((item) => item as Map<String, dynamic>).toList(),
          );
        } else {
          final List<dynamic> dataList = responseBody;
          apiStatisticalArea.clear();
          apiStatisticalArea.value =
              dataList.map((item) => StatisticalArea.fromJson(item)).toList();
        }
      }
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllRequestCategory() async {
    final url = Uri.parse('${AppSettings.baseUrl}apply-for-help/request-types');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);

      requestCat.clear();
      final List<dynamic> data = apiResponse;
      requestCat.assignAll(
        data.map((item) => item as Map<String, dynamic>).toList(),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAllCrimes() async {
    final url = Uri.parse('${AppSettings.baseUrl}apply-for-help/crimes');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);

      allCrimes.clear();
      final List<dynamic> data = apiResponse;
      allCrimes.assignAll(
        data.map((item) => item as Map<String, dynamic>).toList(),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAllJustisRequestTypes() async {
    final url = Uri.parse(
      '${AppSettings.baseUrl}justice/support-rebuild-category',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);
      requestTypes.clear();
      final List<dynamic> data = apiResponse['data'];
      requestTypes.assignAll(
        data.map((item) => item as Map<String, dynamic>).toList(),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getUserDetails() async {
    nameController.text = box.read('name') ?? '';
    contactController.text = box.read('phone') ?? '';
  }
}
