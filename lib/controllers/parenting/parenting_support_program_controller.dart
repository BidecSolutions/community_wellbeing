import 'dart:convert';
import 'package:community_app/models/parenting_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';

class ParentingSupportController extends GetxController {
  var apiVideoLinks = <VideoLinks>[].obs;
  var isLoading = false.obs;
  final pageHeading = ''.obs;
  final pageDescription = ''.obs;
  final extraHeading = ''.obs;
  final extraDescription = ''.obs;
  late List<dynamic> descriptions = [];
  Future<void> fetchVideo({required int? id, String? filterAge}) async {
    try {
      isLoading.value = true;
      pageHeading.value = '';
      pageDescription.value = '';
      extraHeading.value = '';
      extraDescription.value = '';
      apiVideoLinks.value = [];
      descriptions = [];
      final url = Uri.parse(
        '${AppSettings.baseUrl}parenting/parenting-support-videos',
      );
      final Map<String, dynamic> body = {};
      body['page_id'] = id;
      if (filterAge != null && filterAge.isNotEmpty) {
        body['filter'] = filterAge;
      }
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        pageHeading.value = responseBody['page_details']['heading'];
        pageDescription.value =
            responseBody['page_details']['detail_description'];
        extraHeading.value =
            responseBody['page_details']['extra_heading'] ?? '';
        extraDescription.value =
            responseBody['page_details']['extra_description'] ?? '';
        final List data = responseBody['page_videos'];
        apiVideoLinks.value =
            data.map((item) => VideoLinks.fromJson(item)).toList();

        if (extraDescription.value.isNotEmpty) {
          descriptions = json.decode(extraDescription.value);
        }
      }
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }
}
