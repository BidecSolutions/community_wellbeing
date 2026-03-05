import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../models/parenting_model.dart';
import '../../screens/profile/change_password.dart';

class EarlyLearningResourceController extends GetxController {
  var selectedLeftValue = RxnString();
  var selectedRightValue = RxnString();

  List<String> leftDropdownItems = ['Micheal', 'Anna', 'Tommy'];
  List<String> rightDropdownItems = ['1-2 Years', '3-6 Years', '7-12 Years','12-15 Years','16-18 Years','19-25 Years'].obs;

  var apiPage = <LearnPage>[].obs;
  var apiResourcePage = <ResourcePagesVideoLink>[].obs;
  var isLoading = false.obs;


  Future<void> fetchLearnPages() async {
    final url = Uri.parse('${AppSettings.baseUrl}parenting/learn-page');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(
          [5,6,7,8,9]
        ));
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final List data = responseBody;
        apiPage.value = data.map((item) => LearnPage.fromJson(item)).toList();
      }
  }
  Future<void> resourcePage({required int id, required String name})async {
    final url = Uri.parse('${AppSettings.baseUrl}parenting/parenting-support-videos');
    final Map<String, dynamic> body = {};
    body['page_id'] = id;

    if (selectedRightValue.value != "") {
      body['filter'] = selectedRightValue.value;
    }
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final List data = responseBody['page_videos'];
      apiResourcePage.value = data.map((item) => ResourcePagesVideoLink.fromJson(item)).toList();
      Get.toNamed('/resource_videos', arguments: {'id': id, 'name': name});
    }
  }
  final Map<int, List<Map<String, String>>> resourceVideos = {
    1: [
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
    ],
    2: [
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
    ],
    3: [
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
    ],
    4: [
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
    ],
    5: [
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'v3y5yDnTNiU', 'title': 'Memory Boost Game'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
      {'id': 'GkQmkZNLCeM', 'title': 'Kids Learn Colors'},
    ],
  };

  /// Returns the video list based on resource ID
  List<Map<String, String>> getVideos(int id) => resourceVideos[id] ?? [];
}
