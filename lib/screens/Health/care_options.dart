import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../controllers/health/care_options_controller.dart';
import '../widgets/drawer.dart';

class CareOptions extends StatelessWidget {
  CareOptions({super.key});

  final CareOptionsController controller = Get.put(CareOptionsController());

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
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Māori & Pasifika Care Options',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              //--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Why it Matters',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Healthcare that respects your identity, values, and language leads to better outcomes and more trust.',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Find a Trusted Provider',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.providerCards.length,
                        itemBuilder: (context, index) {
                          final provider =
                              controller.providerCards[index]
                                  as Map<String, dynamic>;
                          final rows = provider['rows'] as List;

                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFD5EBFF), Color(0xFFF5F5F0)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.0, 0.6],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Centered Heading
                                Text(
                                  provider['name'] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // All Rows
                                const SizedBox(height: 16),

                                ...rows.asMap().entries.map((entry) {
                                  final rowIndex = entry.key;
                                  final row =
                                      entry.value as Map<String, dynamic>;

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: rowIndex == 0 ? 10 : 20,
                                      vertical: 6,
                                    ),
                                    child:
                                        rowIndex == 0
                                            ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  row['label1'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                // const Spacer(),
                                                SizedBox(width: 18),
                                                if (row['image2'] != null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          right: 8,
                                                        ),
                                                    child: Image.asset(
                                                      row['image2'],
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    row['label2'],
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts
                                                              .primaryFontFamily,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                            : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Left column: image1 + label1
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (row['image1'] != null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                right: 8,
                                                              ),
                                                          child: Image.asset(
                                                            row['image1'],
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                      Flexible(
                                                        child: Text(
                                                          row['label1'],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                AppFonts
                                                                    .primaryFontFamily,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Right column: image2 + label2
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (row['image2'] != null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                right: 8,
                                                              ),
                                                          child: Image.asset(
                                                            row['image2'],
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                      Flexible(
                                                        child: Text(
                                                          row['label2'],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                AppFonts
                                                                    .primaryFontFamily,
                                                            fontSize: 11,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                  );
                                }),

                                // Book Now Button
                                ElevatedButton(
                                  onPressed: () {
                                    // handle booking
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Book Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppFonts.primaryFontFamily,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
}
