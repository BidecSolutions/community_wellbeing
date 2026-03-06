import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/justice/mcqs_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  final MCQController controller = Get.put(MCQController());
  final String title;
  final String subtitle;

  QuizScreen({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: title,
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
                profile: true,
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),

              Center(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Obx(() {
                  if (controller.multipleChoiceQuestions.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.multipleChoiceQuestions.length,
                    itemBuilder: (context, questionIndex) {
                      final question = controller.multipleChoiceQuestions[questionIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question ${questionIndex + 1}: ",
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

                            // Determine checkbox color after submission
                            // Color getCheckboxColor(Set<MaterialState> states) {
                            //   if (!controller.isSubmitted.value)
                            //     return Colors.grey;
                            //   if (isCorrect) return Colors.green;
                            //   if (isSelected && !isCorrect) return Colors.red;
                            //   return Colors.grey;
                            // }

                            // Convert index to option ID (A, B, C, D...)
                            String optionId = String.fromCharCode(
                              65 + optionIndex,
                            );

                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                                // vertical: 4,
                              ),
                              title: Text(
                                "$optionId. ${question.ans[optionIndex].options}",
                                style: TextStyle(
                                  fontFamily: AppFonts.secondaryFontFamily,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Checkbox(
                                value: isSelected ,
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
                                  if (!controller.isSubmitted.value) {
                                    return Colors.white;
                                  }
                                  if (isCorrect) {
                                    return Colors.green;
                                  }
                                  if (isSelected && !isCorrect) {
                                    return Colors.red;
                                  }
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
                        ],
                      );
                    },
                  );
                }),
              ),
              Center(
                child: ElevatedButton(
                  onPressed:
                      controller.isSubmitted.value ? null : controller.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5B2DEE),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Check Results",
                    style: TextStyle(
                      color: AppColors.whiteTextField,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
