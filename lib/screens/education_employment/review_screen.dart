import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/models/child_safety_model.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ReviewAnswerScreen extends StatefulWidget {
  final List<McQs> userAnswers;

  const ReviewAnswerScreen({super.key, required this.userAnswers});

  @override
  State<ReviewAnswerScreen> createState() => _ReviewAnswerScreenState();
}

class _ReviewAnswerScreenState extends State<ReviewAnswerScreen> {
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
              children: [
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Your Learning Path',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.userAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = widget.userAnswers[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${index + 1}:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          answer.questions,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        ...List.generate(answer.ans.length, (i) {
                          final option = answer.ans[i];
                          final isCorrect = i == (answer.rightAnswer - 1);
                          final isSelected = i == answer.selectedAnswerIndex;

                          Color? color;
                          if (isCorrect) {
                            color = Colors.green;
                          } else if (isSelected && !isCorrect) {
                            color = Colors.red;
                          }

                          return ListTile(
                            leading: Checkbox(
                              value:
                                  isSelected ||
                                  isCorrect, // mark correct + selected
                              onChanged: null, // read-only
                              checkColor: Colors.white,
                              fillColor: WidgetStateProperty.resolveWith(
                                (states) => color ?? Colors.white,
                              ),
                            ),
                            title: Text(option.options),
                          );
                        }),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
