import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/child_safety_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MCQController extends GetxController {
  var multipleChoiceQuestions = <McQs>[].obs;
  var isSubmitted = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchQuestions();
    super.onInit();
  }

  void fetchQuestions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(
        '${AppSettings.baseUrl}justice/multiple-choice-question',
      );
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1, "questionType": "education"}),
      );

      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print('response: $responseBody');
        final List data = responseBody['data'];
        multipleChoiceQuestions.value =
            data.map((e) => McQs.fromJson(e)).toList();
      } else {
        errorMessage.value = "Failed to load questions";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectAnswer(int questionIndex, int selectedIndex) {
    if (isSubmitted.value) return;
    multipleChoiceQuestions[questionIndex].selectedAnswerIndex = selectedIndex;
    multipleChoiceQuestions.refresh();
  }

  void submit() {
    isSubmitted.value = true;
    multipleChoiceQuestions.refresh();
  }
}
