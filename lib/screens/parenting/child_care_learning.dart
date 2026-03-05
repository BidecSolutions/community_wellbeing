import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';

class ChildCareLearning extends StatelessWidget {
  const ChildCareLearning({super.key});

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
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Childcare & Early \nLearning Help',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                // const SizedBox(height: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //--- Can I Get Help Paying for Childcare? start --
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Can I Get Help Paying for Childcare?',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Many families are eligible for a childcare subsidy to help with daycare or preschool costs.',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontFamily: AppFonts.primaryFontFamily,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          // house start
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/healthy_homes_application');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/child_age.png",
                                      ),
                                    ),

                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'Based on income, hours needed, and child’s age',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // bed end
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // house end
                          // location start
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/helpline_schedule');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/3_5_years.png",
                                      ),
                                    ),

                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'You may also get 20 Hours Free ECE for 3–5 year olds',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // bed end
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // location end
                          // bed start
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/overcrowding_support_request');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD5EBFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/lincesed_provider.png",
                                      ),
                                    ),

                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                // const SizedBox(height: 4),
                                                Text(
                                                  'Applies to licensed providers (kindergarten, kōhanga reo, etc.)',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // bed end
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed('/home_repair_support');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Check You Eligibility',
                                  style: TextStyle(
                                    fontFamily: AppFonts.primaryFontFamily,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //--- Can I Get Help Paying for Childcare? end --

                      // ---Find a Safe Place to Learn & Grow utility crises starts here ---
                      const SizedBox(height: 40),

                      // New section with grids and button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Find a Safe Place to Learn & Grow',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Two half width grids
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD5EBFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/parenting/preschool.png',
                                            height: 30,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Preschools & Kindergartens',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/parenting/home_based.png',
                                            height: 40,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Home-Based Care',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/parenting/led_centers.png',
                                            height: 40,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Culturally-Led Centres',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/home_repair_support');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Get Location',
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- Find a Safe Place to Learn & Grow end --
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'School Transition Support',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can dress themselves (e.g., put on shoes, zip jacket)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can use the toilet independently",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can recognize and say their name",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can speak in short, clear sentences",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can sit and focus for short periods (5–10 minutes)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can follow simple instructions (like “put your bag away”)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can take turns and play cooperatively",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Can ask for help when needed",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
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
