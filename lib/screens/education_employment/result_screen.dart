import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/ready_for_license_controller.dart';
import 'package:community_app/models/child_safety_model.dart';
import 'package:community_app/screens/education_employment/review_screen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;

  final List<McQs> userAnswers;

  const ResultScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.userAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadyForLicenseController());
    double correctProgress =
        widget.totalQuestions == 0
            ? 0
            : widget.correctAnswers / widget.totalQuestions;
    double incorrectProgress =
        widget.totalQuestions == 0
            ? 0
            : widget.incorrectAnswers / widget.totalQuestions;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Test Summary',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),
              SizedBox(height: 10),
              Text(
                'Your Performance Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Check your score and get tips to help you ace the real test.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Your Performance Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Total Questions (Full bar)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Questions: '),
                  Text('${widget.totalQuestions}'),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                value: 1.0,
                color: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor,
                minHeight: 20,
              ),
              SizedBox(height: 30),

              // Correct Answers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Correct Answers:'),
                  Text('${widget.correctAnswers}'),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                value: correctProgress,
                color: AppColors.primaryColor,
                // backgroundColor: AppColors.primaryColor,
                minHeight: 20,
              ),
              SizedBox(height: 30),

              // Incorrect Answers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Incorrect Answers:'),
                  Text('${widget.incorrectAnswers}'),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                value: incorrectProgress,
                color: AppColors.primaryColor,
                // backgroundColor: AppColors.primaryColor,
                minHeight: 20,
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => ReviewAnswerScreen(
                        userAnswers: controller.userAnswers,
                      ),
                    )!.then((_) {
                      final controller = Get.find<ReadyForLicenseController>();

                      // refresh points after review
                      controller.fetchPoints();

                      controller.resetQuiz();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5B2DEE),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Review Your Answers",
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.primaryFontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
