import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/drawer.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

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
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Health & Wellbeing',
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
              /* ─────────── App-bar End ─────────── */
              // --- Emergency Help & Clinic Access Start--
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ───── Heading ───── */
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Emergency Help & Clinic Access',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Not sure what to do in a health emergency? Get quick help, trusted advice, and real-time clinic info.',
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

                    // New section with grids and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          // Two half width grids 1st
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // call start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final Uri phoneUri = Uri(
                                        scheme: 'tel',
                                        path: '111',
                                      );
                                      if (await canLaunchUrl(phoneUri)) {
                                        await launchUrl(phoneUri);
                                      } else {}
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/call.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Call to 111',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // call end
                                const SizedBox(width: 16),
                                // not sure start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/not_sure');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD5EBFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/not_sure.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Not Sure If It’s Serious?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // not sure end
                              ],
                            ),
                          ),
                          // Two half width grids 1st end
                          const SizedBox(height: 16),
                          // two half grid 2nd start
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // call start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/someone_know');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFCDFFDA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/someone_know.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Let Someone Know You’re Okay',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // call end
                                const SizedBox(width: 16),
                                // not sure start
                                // Expanded(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Get.toNamed('/care_options');
                                //     },
                                //     child: Container(
                                //       padding: const EdgeInsets.all(30),
                                //       decoration: BoxDecoration(
                                //         color: Color(0xFFFFF0CA),
                                //         borderRadius: BorderRadius.circular(12),
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           Image.asset(
                                //             'assets/images/health/your_doctor.png',
                                //             height: 50,
                                //             fit: BoxFit.contain,
                                //           ),
                                //           const SizedBox(height: 25),
                                //           Text(
                                //             'Your Doctor',
                                //             textAlign: TextAlign.center,
                                //             style: TextStyle(
                                //               fontFamily:
                                //                   AppFonts.secondaryFontFamily,
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 16,
                                //               color: Colors.black,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // not sure end
                              ],
                            ),
                          ),
                          // Two half width grids 2nd end
                        ],
                      ),
                    ),
                    // --- Emergency Help & Clinic Access end --

                    //---Culturally Safe Healthcare start--
                    const SizedBox(height: 40),
                    /* ───── Heading ───── */
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Culturally Safe Healthcare',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find care that respects your values, your whānau, and your location.',
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
                    // const SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed('/care_options');
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     padding: const EdgeInsets.all(16),
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFFFEDBDF),
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         // Image on the left
                    //         Image.asset(
                    //           'assets/images/health/care_option.png',
                    //           height: 60,
                    //           // width: 60,
                    //           fit: BoxFit.contain,
                    //         ),
                    //         const SizedBox(width: 12),
                    //
                    //         // Text content on the right
                    //         Expanded(
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 'Māori & Pasifika Care Options',
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontFamily: AppFonts.secondaryFontFamily,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 6),
                    //               Text(
                    //                 'Dedicated support that honours the cultural identity and wellbeing of Māori and Pasifika peoples.',
                    //                 style: TextStyle(
                    //                   fontFamily: AppFonts.primaryFontFamily,
                    //                   fontSize: 14,
                    //                   color: Color(0xFF4C4C4C),
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 10),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    //--- Culturally Safe Healthcare end--

                    // --- Healthy living start --
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
                                  'Healthy Living & Prevention',
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
                          const SizedBox(height: 25),

                          // Full width grid
                          GestureDetector(
                            onTap:
                                () => Get.toNamed('/HealthyLivingPrevention'),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF0CA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/health/healthy_living.png',
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Healthy Habits, Happy Whānau',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Track steps, improve meals, and join fun whānau challenges — all in one place.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // --- Healthy living end --

                    //--- Family Health Support Start --

                    /* ───── Heading ───── */
                    const SizedBox(height: 40),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Family Health Support',
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
                            'Support your whānau’s health journey with the right tools, reminders, and culturally friendly guidance.',
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

                    /* ───── Custom Grid Layout ───── */
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Row(
                              children: [
                                _imageTile(
                                  'assets/images/health/know_Sick.png',
                                  flex: 1,

                                  onTap: () => Get.toNamed('/know_when_sick'),
                                ),

                                const SizedBox(width: 12),
                                _imageTile(
                                  'assets/images/health/child_health.png',
                                  flex: 1,
                                  onTap:
                                      () => Get.toNamed('/milestone_checklist'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //--- Family Health Support end ---
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Mind & Whānau Support',
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
                            'Tools to support your mental health, strengthen whānau, and feel more connected — every day.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        // mental health start
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/find_a_provider');
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEDBDF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/health/mental_health.png",
                                    ),
                                  ),

                                  const SizedBox(width: 8),
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
                                                'Mental Health Support',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'Help with anxiety, stress, and more',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppFonts
                                                          .primaryFontFamily,
                                                  color: AppColors.hintColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.contain,
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
                        // mental health end
                        // location start
                        // SizedBox(height: 8),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed('/stay_connected');
                        //   },
                        //   child: Card(
                        //     elevation: 0,
                        //     color: Colors.white,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(10.0),
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             padding: const EdgeInsets.all(12),
                        //             decoration: BoxDecoration(
                        //               color: const Color(0xFFFFF0CA),
                        //               borderRadius: BorderRadius.circular(12),
                        //             ),
                        //             child: Image.asset(
                        //               "assets/images/health/stay_connected.png",
                        //             ),
                        //           ),
                        //
                        //           const SizedBox(width: 8),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               children: [
                        //                 Expanded(
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: const [
                        //                       Text(
                        //                         'Stay Connected',
                        //                         style: TextStyle(
                        //                           fontSize: 14,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily:
                        //                               AppFonts
                        //                                   .secondaryFontFamily,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         'Feel less alone, stay connected',
                        //                         style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontFamily:
                        //                               AppFonts
                        //                                   .primaryFontFamily,
                        //                           color: AppColors.hintColor,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Image.asset(
                        //                   'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                        //                   height: 30,
                        //                   width: 30,
                        //                   fit: BoxFit.contain,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           // bed end
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // location end
                        // bed start
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/youth_wellbeing');
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD5EBFF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/health/youth_well.png",
                                    ),
                                  ),

                                  const SizedBox(width: 8),
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
                                                'Youth Wellbeing',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'Calm tools for stress and identity',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppFonts
                                                          .primaryFontFamily,
                                                  color: Color(0xFF4C4C4C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.contain,
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _imageTile
  Widget _imageTile(
    String imagePath, {
    required int flex,
    VoidCallback? onTap,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
