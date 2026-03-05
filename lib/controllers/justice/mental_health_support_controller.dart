
import 'dart:convert';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/parenting_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';

class MentalHealthSupportPage {
  final int id;
  final String heading;
  final String subHeading;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MentalHealthSupport> videos;
  var apiVideoLinks = <MentalHealthSupport>[].obs;

  MentalHealthSupportPage({
    required this.id,
    required this.heading,
    required this.subHeading,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });

  factory MentalHealthSupportPage.fromJson(Map<String, dynamic> json) =>
      MentalHealthSupportPage(
        id: json["id"],
        heading: json["heading"],
        subHeading: json["sub_heading"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        videos: List<MentalHealthSupport>.from(
          json["videos"].map((x) => MentalHealthSupport.fromJson(x)),
        ),
      );
}

class MentalHealthSupportController extends GetxController {
  var apiVideoLinks = <MentalHealthSupport>[].obs;
  var isLoading = false.obs;
  final pageHeading = ''.obs;
  final pageDescription = ''.obs;

  Future<void> fetchVideo() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${AppSettings.baseUrl}justice/mental-support');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        pageHeading.value = data['heading'];
        pageDescription.value = data['sub_heading'];

        final List videos = data['videos'];
        apiVideoLinks.value =
            videos.map((item) => MentalHealthSupport.fromJson(item)).toList();

        final page = MentalHealthSupportPage.fromJson(data);
        pageHeading.value = page.heading;
        pageDescription.value = page.subHeading;
        apiVideoLinks.value = page.videos;
      } else {

      }
    } catch (e) {
        e;
    } finally {
      isLoading.value = false;
    }
  }
}
