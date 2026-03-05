import 'dart:convert';
import 'dart:ui';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/models/safety_awareness_model.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SafetyAwarenessController extends GetxController {
  var programs = <SafetyAwarenessModel>[].obs; // List of program tiles
  var isLoading = false.obs;
  var videos = <ChildSafetyModel>[].obs;

  @override
  void onInit() {
    fetchSafetyAwarenessPrograms();
    super.onInit();
  }

  Future<List<SafetyAwarenessModel>> fetchSafetyAwarenessPrograms() async {
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}justice/awareness-categories',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'];
        programs.value =
            data.map((e) => SafetyAwarenessModel.fromJson(e)).toList();
        return programs;
      } else {
        throw Exception('Failed to load programs');
      }
    } catch (e) {
      throw Exception("Error fetching safety awareness data: $e");
    }
  }

  Future<void> fetchChildSafetyVideos(int categoryId) async {
    isLoading.value = true;
    try {
      final uri = Uri.parse(
        '${AppSettings.baseUrl}justice/awareness-category-videos',
      );
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },

        body: jsonEncode({"categoryId": categoryId}),
      );

      final responseBody = json.decode(response.body);
      if (response.statusCode == 201) {
        final List videoList = responseBody['data'];
        videos.value =
            videoList.map((video) => ChildSafetyModel.fromJson(video)).toList();
      } else {
        videos.clear();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Color parseHexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";
    return Color(int.parse(hexColor, radix: 16));
  }
}
