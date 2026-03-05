import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/culture/culture_community_controller.dart';
import 'package:community_app/controllers/social_support/social_support_controller.dart';
import 'package:community_app/screens/widgets/player.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/seminar_and_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';

class CultureCommunity extends StatefulWidget {
  const CultureCommunity({super.key});

  @override
  State<CultureCommunity> createState() => _CultureCommunityState();
}

class _CultureCommunityState extends State<CultureCommunity> {
  final link = AppSettings.baseUrl;
  final cultureController = Get.put(CultureCommunityController());
  final controller = Get.put(SocialSupportController());
  @override
  void initState() {
    super.initState();
    controller.fetchNavigator();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Culture Community',
                  showBottom: true,
                  userName: false,
                  showNotificationIcon: false,
                ),
                const SizedBox(height: 20),
                Text(
                  'Community Navigators Near You',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(height: 20),
                Obx(() {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.navigators.length,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        final item = controller.navigators[index];
                        return Container(
                          width: 150, // Width per card
                          margin: const EdgeInsets.only(right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  link + (item['image'] ?? ''),
                                  height: 160,
                                  width: 240,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['name'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: AppColors.hintColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['location'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.hintColor,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 150,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      arguments: item['id'],
                                      '/community-navigator',
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFonts.primaryFontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(height: 25),
                SizedBox(child: SeminarAndEvents(category: [2])),
                const SizedBox(height: 25),
                SizedBox(height: 60),
                Text(
                  "Host Your Own Event",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Get.toNamed('/host_an_event');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F0FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.celebration,
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Bring Whānau Together",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Bring The Community Together — We’ll Help You Get Started",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                // Bottom Text Section
                Text(
                  "Know Your Roots. Grow Your Voice.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Explore Your Heritage Through Language And Local Wisdom.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/do_you_know_your_culture',
                      arguments: {
                        'title': "How Well Do You Know Your Culture?",
                      },
                    );
                  },
                  child: _buildInfoCard(
                    backgroundColor: const Color(0xFFE5F0FF), // Light Blue
                    imagePath: 'assets/images/culture/culture.png',
                    iconColor: Colors.blue,
                    title: "How Well Do You Know Your Culture?",
                    subtitle:
                        "Discover Facts, Traditions, And Stories From Your Region Or Iwi",
                  ),
                ),
                const SizedBox(height: 16),

                // Second Card
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/language_corner');
                  },
                  child: _buildInfoCard(
                    backgroundColor: Color(0xFFFFE7EA),
                    imagePath: 'assets/images/culture/language.png',
                    iconColor: Colors.red,
                    title: "Language Corner",
                    subtitle:
                        "Grow Your Cultural Connection By Learning Local Languages At Your Own Pace.",
                  ),
                ),
                const SizedBox(height: 70),

                // Section Title Below Cards
                Text(
                  "Stories Of Whānau & Community",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                const Player(),

                // CarouselSlider(
                //   options: CarouselOptions(
                //     height: 200.0,
                //     autoPlay: false,
                //     enlargeCenterPage: true,
                //     viewportFraction: 0.8,
                //   ),
                //   items:
                //       cultureController.videoIds.asMap().entries.map((entry) {
                //         final index = entry.key;
                //         final videoId = entry.value;
                //         final thumbnail =
                //             cultureController.thumbnails[index]['url'];
                //         return GestureDetector(
                //           onTap: () {
                //             Get.to(
                //               Videos(videoId: videoId),
                //               arguments: {'videoId': videoId},
                //             );
                //           },
                //           child: Stack(
                //             children: [
                //               Container(
                //                 margin: const EdgeInsets.all(8.0),
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(10.0),
                //                   child: CachedNetworkImage(
                //                     imageUrl: thumbnail,
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 top: 45,
                //                 left: 100,
                //                 child: Icon(
                //                   Icons.play_arrow,
                //                   color: Colors.white,
                //                   size: 45,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       }).toList(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoCard({
  required Color backgroundColor,
  required String imagePath,
  required Color iconColor,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        // Colored Icon Container
        Container(
          height: 80,
          width: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(imagePath, color: iconColor),
        ),
        const SizedBox(width: 16),

        // Text Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
