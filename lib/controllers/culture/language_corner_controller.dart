import 'dart:convert';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/language_corner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LanguageCornerController extends GetxController {
  Rx<YoutubePlayerController?> ytController = Rx<YoutubePlayerController?>(
    null,
  );
  RxString currentVideoId = ''.obs;
  var selectedLanguage = 'English'.obs;
  RxList<String> languages = <String>[].obs;
  RxList<VideoModel> videos = <VideoModel>[].obs;

  void changeLanguage(String language) {
    selectedLanguage.value = language;
    fetchPlaylist();
    update();
  }

  int get selectedLanguageId => languages.indexOf(selectedLanguage.value) + 1;
  // int get selectedLanguageId =>
  //     languages.contains(selectedLanguage.value)
  //         ? languages.indexOf(selectedLanguage.value) + 1
  //         : 0;

  Future<void> fetchLanguages() async {
    if (languages.isNotEmpty) return;

    final url = Uri.parse('${AppSettings.baseUrl}culture/get-all-language');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      languages.value = data.map((lang) => lang['name'].toString()).toList();

      if (!languages.contains(selectedLanguage.value)) {
        selectedLanguage.value = languages.first;
      } 
      update();
      fetchPlaylist();
    } else {
      print('Failed to fetch languages: ${response.statusCode}');
    }
    try {} catch (e) {
      print('Error fetching languages: $e');
    }
  }

  void playVideo(String videoId) {
    currentVideoId.value = videoId;

    if (ytController.value != null) {
      ytController.value!.load(videoId);
    } else {
      ytController.value = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );
    }
    update(); // if using GetBuilder
  }

  Future<void> fetchPlaylist() async {
    final alreadyFetched = videos.any(
      (v) => v.languageId == selectedLanguageId,
    );
    if (alreadyFetched) return;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}culture/get-playlist');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"language_id": selectedLanguageId}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        for (var item in data) {
          final List<VideoItemModel> videoList =
              (item['list'] as List)
                  .map(
                    (video) => VideoItemModel(
                      id: video['id'],
                      videoLink: video['video_link'],
                      videoHeading: video['video_heading'],
                      videoDescription: video['video_description'],
                      thumbnailId: video['thumbnail_id'],
                      status: video['status'] ?? 0,
                    ),
                  )
                  .toList();

          videos.add(
            VideoModel(
              id: item['id'],
              thumbnailImage:
                  "${AppSettings.baseUrl}${item['thumbnail_image']}",
              thumbnailDescription: item['thumbnail_description'],
              languageId: item['language_id'],
              status: item['status'],
              createdAt: item['created_at'],
              updatedAt: item['updated_at'],
              videos: videoList,
            ),
          );
        }
        update();
      } else {
        print('Failed to fetch playlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching playlist: $e');
    }
  }

  /// Save progress of a video (between 0.0 to 1.0)
  Future<void> saveProgress(
    String videoId,
    double currentSeconds,
    double totalSeconds,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final progress = currentSeconds / totalSeconds;

    await prefs.setDouble('progress_$videoId', progress);

    // Optional: Mark as watched if more than 90% viewed
    if (progress >= 0.9) {
      await prefs.setBool('watched_$videoId', true);
    }
  }

  /// Get progress for video (0.0 to 1.0)
  Future<double> getProgress(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('progress_$videoId') ?? 0.0;
  }

  /// Check if video is fully watched (>=90%)
  Future<bool> isWatched(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('watched_$videoId') ?? false;
  }

  void stopVideo() {
    ytController.value?.pause();
    ytController.value = null;
    update();
  }

  @override
  void onClose() {
    ytController.value?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchLanguages();
  }
}
