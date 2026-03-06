import 'package:community_app/controllers/justice/mental_health_support_controller.dart';
import 'package:community_app/controllers/justice/safety_awareness.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/justice/justice_safety_controller.dart';
import '../widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/seminar_and_events.dart';

class Justice extends StatelessWidget {
  Justice({super.key});
  final JusticeSafetyController controller = Get.put(JusticeSafetyController());
  final SafetyAwarenessController safetyAwarenessController = Get.put(
    SafetyAwarenessController(),
  );
  final MentalHealthSupportController mentalHealthSupport = Get.put(
    MentalHealthSupportController(),
  );

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
                screenName: 'Justice & Safety',
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
              // --- Emergency Help & Clinic Access Start--
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Safety Awareness',
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

                          // New section with grids and button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: SizedBox(
                              child: Obx(() {
                                if (safetyAwarenessController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(12),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 3 / 3,
                                      ),
                                  itemCount:
                                      safetyAwarenessController.programs.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        safetyAwarenessController
                                            .programs[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        final selectedItem =
                                            safetyAwarenessController
                                                .programs[index];
                                        await safetyAwarenessController
                                            .fetchChildSafetyVideos(
                                              selectedItem.id,
                                            );
                                        Get.toNamed(
                                          '/child_safety',
                                          arguments: selectedItem,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: safetyAwarenessController
                                              .parseHexColor(item.color),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              item.icon,
                                              height: 50,
                                              fit: BoxFit.contain,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Image.asset(
                                                  'assets/images/justice/child_safety.png',
                                                  height: 50,
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 18),
                                            Text(
                                              item.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Change Yourself',
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
                        GestureDetector(
                          onTap: () async {
                            await mentalHealthSupport.fetchVideo();
                            Get.toNamed('/mental_health_support');
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
                                      "assets/images/justice/mentl_health.png",
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
                                                'Mental Health & Inner strength',
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
                        // location end
                        // bed start
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/jobs');
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
                                      color: const Color(0xFFFFF0CA),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/justice/jobs.png",
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
                                                'Jobs',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'Feel less alone, stay connected',
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

                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              '/quizscreen',
                              arguments: {
                                'title': 'Test Your Safety Awareness',
                                'subtitle': 'Your Guide to Everyday Safety',
                              },
                            );
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
                                      color: const Color(0xFFCDFFDA),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/justice/test_your_safety.png",
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
                                                'Test Your Safety Awareness',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'Your Guide to Everyday Safety',
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

                    // --- Get the support you need start  ---
                    const SizedBox(height: 20),

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
                                  'Get the Support You Deserve',
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

                          // Two half width grids
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/rebuild_life_foam');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/justice/get_support.png',
                                            height: 40,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Get Support to Rebuild your Life',
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
                                            'This isn’t just a help request — it’s about hope, rehabilitation, and second chances.',
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
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/request_mentor');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/justice/request_an_mentor.png',
                                            height: 40,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Request an mentor to support you',
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
                                            'This isn’t just a help request — it’s about hope, rehabilitation, and second chances.',
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- Get the support you need start end --

                    // --- emergency start--
                    const SizedBox(height: 40),

                    // NEmergency grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Emergency Help',
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

                          // Full width grid
                          GestureDetector(
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
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFEDBDF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/health/call.png',
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Call to 111',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
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
                    // --- emergency end --
                    // --- safe reach out start
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),

                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Feel Safe. Reach Out',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
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
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFD5EBFF),
                                        Color(0xFFF5F5F0),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.0, 0.6],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Centered Heading
                                      Text(
                                        provider['name'] as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.secondaryFontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // All Rows
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        row['label1'],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppFonts
                                                                  .primaryFontFamily,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      // const Spacer(),
                                                      if (row['image2'] != null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                right: 8,
                                                                left: 18,
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
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  : Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Left column: image1 + label1
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (row['image1'] !=
                                                                null)
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
                                                                    TextAlign
                                                                        .left,
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
                                                            if (row['image2'] !=
                                                                null)
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
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                        );
                                      }),

                                      const SizedBox(height: 16),

                                      // Book Now Button
                                      ElevatedButton(
                                        onPressed: () {
                                          // handle booking
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 24,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Book Now",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
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
                    //--- safe reach out end--
                  ],
                ),
              ),

              SizedBox(child: SeminarAndEvents(category: [1])),
            ],
          ),
        ),
      ),
    );
  }
}
