import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/ready_for_license_controller.dart';
import 'package:community_app/screens/education_employment/ready_for_license.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseQuizStart extends StatefulWidget {
  const LicenseQuizStart({super.key});

  @override
  State<LicenseQuizStart> createState() => _LicenseQuizStartState();
}

class _LicenseQuizStartState extends State<LicenseQuizStart> {
  final controller = Get.put(ReadyForLicenseController());

  @override
  void initState() {
    controller.fetchPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Score card
                  MyAppBar(
                    showMenuIcon: true,
                    showBackIcon: true,
                    screenName: 'Start Practice Test',
                    showBottom: false,
                    userName: false,
                    showNotificationIcon: false,
                  ),
                  SizedBox(height: 30),
                  Obx(() {
                    if (controller.points.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.points.length,
                        itemBuilder: (context, index) {
                          final points = controller.points[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteTextField,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        color: Colors.deepPurple,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "No. of Questions: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${points['no_of_questions']}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber.shade700,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Previous Score: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${points['point_gains']}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "No previous attempts yet.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      final controller = Get.find<ReadyForLicenseController>();
                      controller.resetQuiz();
                      controller.fetchQuestions();
                      Get.to(() => ReadyForLicense());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5B2DEE),
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Start Test",
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.primaryFontFamily,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
