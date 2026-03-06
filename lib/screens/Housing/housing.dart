import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/healthy_homes_controller.dart';
import '../widgets/drawer.dart';

final controller = Get.put(HealthyHomeController());

class HousingPage extends StatelessWidget {
  const HousingPage({super.key});

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
                screenName: 'Housing Quality',
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


              /* ─────────── App-bar End ─────────── */
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
                            'Cold, Damp & Unsafe Homes',
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
                            'Many homes lack proper insulation and ventilation, leading to health issues.',
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
                    SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 195,
                            child: Row(
                              children: [
                                _imageTile(
                                  'assets/images/housing/housing1.png',
                                  flex: 3,
                                ),
                                const SizedBox(width: 12),
                                _imageTile(
                                  'assets/images/housing/housing2.png',
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                _imageTile(
                                  'assets/images/housing/housing3.png',
                                  flex: 2,
                                ),
                                const SizedBox(width: 12),
                                _imageTile(
                                  'assets/images/housing/housing4.png',
                                  flex: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    /* ───── Button ───── */
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/healthy_homes_application');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Request a Home inspection',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.primaryFontFamily,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --- utility crises starts here ---
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
                                  'Utility Crises & Emergency Repairs',
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFD5EBFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/housing/warning.png',
                                  height: 48,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Small Issues, Big Stress',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Water leaks, faulty heaters, or broken switches can make home life harder — especially for tamariki and kaumātua.',
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

                          const SizedBox(height: 20),

                          // Two half width grids
                          IntrinsicHeight(
                            child: Row(
                              children: [
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
                                          'assets/images/housing/clock.png',
                                          height: 30,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Help Takes Too Long',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Request urgent help from trusted local repair services.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                            fontSize: 13,
                                            color: Color(0xFF4C4C4C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

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
                                          'assets/images/housing/bulb.png',
                                          height: 40,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Real Help Starts Here',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Request urgent help from trusted local repair services.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                            fontSize: 13,
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
                                  'Submit Report',
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

                    // --- utility crises end --

                    //--- Trusted Repair Services start --
                    const SizedBox(height: 40),
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
                            'Trusted Repair Services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Connect with vetted local tradies who respect your whānau’s culture and needs—choose female technicians or koha-based pricing for reliable, community-backed home repairs.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.primaryFontFamily,
                              color: Color(0xFF4C4C4C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              Get.toNamed('/request_trustie_community_tradie');
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Submit Your Request',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //--- Trusted Repair Services end --

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageTile(String imagePath, {required int flex}) {
    return Expanded(
      flex: flex,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
