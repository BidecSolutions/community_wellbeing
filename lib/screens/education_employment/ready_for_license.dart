import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/ready_for_license_controller.dart';
import 'package:community_app/screens/education_employment/result_screen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadyForLicense extends StatefulWidget {
  const ReadyForLicense({super.key});

  @override
  State<ReadyForLicense> createState() => _ReadyForLicenseState();
}

class _ReadyForLicenseState extends State<ReadyForLicense> {
  final controller = Get.put(ReadyForLicenseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Get Ready for Your Licence',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Practice with timed mock tests and prepare confidently — available in English, Te Reo Māori, and Pasifika languages.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.errorMessage.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    }

                    if (controller.multipleChoiceQuestions.isEmpty) {
                      return Center(child: Text("No questions available."));
                    }

                    final question =
                        controller.multipleChoiceQuestions[controller
                            .currentQuestionIndex
                            .value];

                    final questionIndex = controller.currentQuestionIndex.value;
                    int total = controller.multipleChoiceQuestions.length;
                    int current = controller.currentQuestionIndex.value + 1;

                    // double progress = total == 0 ? 0 : current / total;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LinearProgressIndicator(
                        //   value: progress,
                        //   color: AppColors.accentColor,
                        //   backgroundColor: Colors.grey.shade300,
                        //   minHeight: 8,
                        // ),
                        SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Circular progress border
                                Obx(() {
                                  double progress =
                                      controller.timeLeft.value /
                                      30; // total time = 30s

                                  return SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      value: progress,
                                      strokeWidth: 10,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                  );
                                }),

                                // Inner content
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Time Left'),
                                    const SizedBox(height: 4),
                                    Obx(
                                      () => Text(
                                        "${controller.timeLeft.value}",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.accentColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Text('Sec'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Question $current of $total"),
                        SizedBox(height: 20),
                        Text(
                          "Question ${questionIndex + 1}:",
                          style: TextStyle(
                            fontFamily: AppFonts.primaryFontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          question.questions,
                          style: TextStyle(
                            fontFamily: AppFonts.secondaryFontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        ...List.generate(question.ans.length, (optionIndex) {
                          final option = question.ans[optionIndex];
                          final isCorrect =
                              controller.isSubmitted.value &&
                              option.id == question.rightAnswer;

                          final isSelected =
                              question.selectedAnswerIndex == optionIndex;

                          String optionId = String.fromCharCode(
                            65 + optionIndex,
                          ); // A, B, C...

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 4),
                            title: Text(
                              "$optionId. ${option.options}",
                              style: TextStyle(
                                fontFamily: AppFonts.secondaryFontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged:
                                  controller.isSubmitted.value
                                      ? null
                                      : (bool? value) {
                                        controller.selectAnswer(
                                          questionIndex,
                                          optionIndex,
                                        );
                                      },
                              checkColor: Colors.black,
                              fillColor: WidgetStateProperty.resolveWith((
                                states,
                              ) {
                                if (!controller.isSubmitted.value)
                                  return Colors.white;
                                if (isCorrect) return Colors.green;
                                if (isSelected && !isCorrect) return Colors.red;
                                return Colors.white;
                              }),
                              side: BorderSide(
                                color: AppColors.accentColor,
                                width: 1,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 20),

                        // Navigation buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (questionIndex <
                                controller.multipleChoiceQuestions.length - 1)
                              ElevatedButton(
                                onPressed: controller.nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5B2DEE),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 100,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),

                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.primaryFontFamily,
                                  ),
                                ),
                              ),
                            if (questionIndex ==
                                controller.multipleChoiceQuestions.length - 1)
                              ElevatedButton(
                                onPressed:
                                    controller.isSubmitted.value
                                        ? null
                                        : () async {
                                          controller.submit();
                                          await controller.fetchSaveResults(
                                            controller
                                                .multipleChoiceQuestions
                                                .length,
                                            controller.score.value,
                                          );
                                          // After submitting, navigate to result screen
                                          Get.off(
                                            () => ResultScreen(
                                              totalQuestions:
                                                  controller
                                                      .multipleChoiceQuestions
                                                      .length,
                                              correctAnswers:
                                                  controller.score.value,
                                              incorrectAnswers:
                                                  controller
                                                      .multipleChoiceQuestions
                                                      .length -
                                                  controller.score.value,
                                              userAnswers:
                                                  controller.userAnswers,
                                            ),
                                          )!.then((_) {
                                            final controller =
                                                Get.find<
                                                  ReadyForLicenseController
                                                >();
                                            controller.fetchPoints();
                                          });
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5B2DEE),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.primaryFontFamily,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
