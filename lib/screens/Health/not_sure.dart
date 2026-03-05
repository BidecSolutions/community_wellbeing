import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_settings/fonts.dart';
import '../../controllers/health/not_sure_controller.dart';
import '../widgets/drawer.dart';

class NotSure extends StatelessWidget {
  NotSure({super.key});

  final NotSureController controller = Get.put(NotSureController());

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
                screenName: 'Not Sure If it\'s Serious?',
                profile:true,
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),
              //--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'Answer a few simple questions to help you decide what to do next — call 111, visit a clinic, or rest at home.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 25),

                      //--- progress bar start --
                      Obx(() {
                        double progress = controller.progress;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Progress bar with internal labels
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300],
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: progress.clamp(0.0, 1.0),
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Good",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Average",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Below Average",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Need Attention",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        );
                      }),

                      //--- progressbar end--
                      //--- check list Start--
                      // Checklist title
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Answer These Quick Questions:',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            // Checklist items
                            ...controller.checklistGroups.entries.map((entry) {
                              int groupStartIndex = controller
                                  .checklistGroups
                                  .entries
                                  .takeWhile((e) => e.key != entry.key)
                                  .fold(0, (sum, e) => sum + e.value.length);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  ...entry.value.asMap().entries.map((item) {
                                    int globalIndex =
                                        groupStartIndex + item.key;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text("• ${item.value}"),
                                        ),
                                        Checkbox(
                                          value:
                                              controller
                                                  .isCheckedList[globalIndex],
                                          onChanged: (bool? value) {
                                            controller
                                                    .isCheckedList[globalIndex] =
                                                value!;
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                                  const SizedBox(height: 12),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),

                      //---check list end --
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD5EBFF), Color(0xFFF5F5F0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0.0,
                              0.6,
                            ], // 0-30% = left color, then fade into right color
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'We’re here to help',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'If you answered Yes to all questions, you may be facing a serious emergency. Call 111 now to get immediate help from trained professionals.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: '111', // Replace with actual phone number
                                );
                                if (await canLaunchUrl(phoneUri)) {
                                  await launchUrl(phoneUri);
                                } else {
                                  // Optionally show a snackbar or error message
                                  print('Could not launch phone dialer');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Color(0xFFFEDBDF),
                                foregroundColor: Color(0xFFFEDBDF),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Call Now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
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
