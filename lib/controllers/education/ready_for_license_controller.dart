import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/child_safety_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReadyForLicenseController extends GetxController {
  var multipleChoiceQuestions = <McQs>[].obs;
  var points = <Map<String, dynamic>>[].obs;
  var saveResults = <Map<String, dynamic>>[].obs;
  var isSubmitted = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;

  void nextQuestion() {
    if (currentQuestionIndex.value < multipleChoiceQuestions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  List<McQs> userAnswers = [];

  void submit() {
    stopTimer();
    isSubmitted.value = true;
    multipleChoiceQuestions.refresh();

    int correctAnswers = 0;
    userAnswers.clear();
    for (var question in multipleChoiceQuestions) {
      final selectedIndex = question.selectedAnswerIndex;

      if (selectedIndex != null &&
          selectedIndex >= 0 &&
          selectedIndex < question.ans.length &&
          selectedIndex == (question.rightAnswer - 1)) {
        correctAnswers++;
      }
      userAnswers.add(question);
    }
    score.value = correctAnswers;
  }

  void resetQuiz() {
    isSubmitted.value = false;
    currentQuestionIndex.value = 0;
    score.value = 0;
    multipleChoiceQuestions.clear();
    fetchQuestions();
  }

  @override
  void onInit() {
    fetchQuestions();
    super.onInit();
  }

  Future<void> fetchQuestions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(
        '${AppSettings.baseUrl}education/driving-license-mcqs',
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
        final List data = responseBody['data'] ?? [];
        multipleChoiceQuestions.value =
            data.map((e) => McQs.fromJson(e)).toList();
        if (data.isNotEmpty) startTimer();
      } else {
        errorMessage.value = "Failed to load questions";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPoints() async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/driving-test-attempt-list',
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
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];
        log('Points: $data');
        points.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to Load Points');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSaveResults(int questions, int points) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        '${AppSettings.baseUrl}education/save-driving-test-results',
      );
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"question": questions, "points": points}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        log('Save Results Response: $jsonResponse');
        final List<dynamic> data = jsonResponse['data'] ?? [];
        log('Points: $data');
        if (jsonResponse['status'] == true) {
          Get.snackbar(
            "Success",
            jsonResponse['message'] ?? "Saved Successfully",
          );
        } else {
          Get.snackbar(
            "Error",
            jsonResponse['message'] ?? "Failed to save results",
          );
        }
      }
    } catch (e) {
      print('Error, ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void selectAnswer(int questionIndex, int selectedIndex) {
    if (isSubmitted.value) return;
    multipleChoiceQuestions[questionIndex].selectedAnswerIndex = selectedIndex;
    multipleChoiceQuestions.refresh();
  }

  Timer? questionTimer;
  var timeLeft = 30.obs;

  void startTimer() {
    timeLeft.value = 30;
    questionTimer?.cancel();

    questionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        autoNextQuestion();
      }
    });
  }

  void autoNextQuestion() {
    if (multipleChoiceQuestions[currentQuestionIndex.value]
            .selectedAnswerIndex ==
        null) {
      multipleChoiceQuestions[currentQuestionIndex.value].selectedAnswerIndex =
          -1;
    }

    if (currentQuestionIndex.value < multipleChoiceQuestions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      submit();
    }
  }

  void stopTimer() {
    questionTimer?.cancel();
    timeLeft.value = 0; // Optional: reset UI display to 0
  }

  @override
  void onClose() {
    questionTimer?.cancel();
    super.onClose();
  }
}
