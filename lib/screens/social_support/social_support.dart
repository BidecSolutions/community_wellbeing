import 'package:community_app/app_settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/social_support/social_support_controller.dart';
import '../widgets/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SocialSupport extends StatefulWidget {
  const SocialSupport({super.key});
  @override
  State<SocialSupport> createState() => _SocialSupportState();
}

class _SocialSupportState extends State<SocialSupport> {
  final controller = Get.put(SocialSupportController());
  final link = AppSettings.baseUrl;
  @override
  void initState() {
    super.initState();
    controller.fetchMainPage();
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
          child: Column(
            children: [
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Social Support',
                showBottom: false,
                profile: true,
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
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.mainHeading.value.toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Obx(
                                  () => Text(
                                    controller.subHeading.value.toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      fontFamily: AppFonts.primaryFontFamily,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //---youtube video start--
                                Obx(() {
                                  String? videoId =
                                      YoutubePlayer.convertUrlToId(
                                        controller.youtubeVideoUrl.value,
                                      );
                                  if (videoId == null) {
                                    return const Text("Video not Avilable.");
                                  }

                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // 👈 adjust radius here
                                    child: YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId: videoId,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                          mute: false,
                                        ),
                                      ),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor:
                                          AppColors.primaryColor,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 8),
                                Obx(
                                  () => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.videoDescription.value,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.copyWith(
                                        fontFamily:
                                            AppFonts.secondaryFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                /* ───── Button ───── */
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed('/request_social_worker');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Request a Social Worker',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //---youtube video end --
                                const SizedBox(height: 40),
                                //---community navigator section start--
                                Text(
                                  'Community Navigators Near You',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Obx(() {
                                  return SizedBox(
                                    height:
                                        250, // Adjust height to fit your content
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.navigators.length,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      itemBuilder: (context, index) {
                                        final item =
                                            controller.navigators[index];
                                        return Container(
                                          width: 150, // Width per card
                                          margin: const EdgeInsets.only(
                                            right: 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      item['name'] ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            AppFonts
                                                                .primaryFontFamily,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        size: 12,
                                                        color:
                                                            AppColors.hintColor,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        item['location'] ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              AppColors
                                                                  .hintColor,
                                                          fontFamily:
                                                              AppFonts
                                                                  .primaryFontFamily,
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
                                                      color:
                                                          AppColors
                                                              .primaryColor,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Book Now',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          AppFonts
                                                              .primaryFontFamily,
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

                                //--- community navigator end --

                                //---community navigator section end--
                                const SizedBox(height: 40),
                                Text(
                                  'Waste & Clean-Up Support',
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
                                  'Proper waste management is crucial for community health.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    fontFamily: AppFonts.primaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: Row(
                                          children: [
                                            _imageTile(
                                              'assets/images/social/waste_cleanup_2.png',
                                              flex: 1,
                                            ),

                                            const SizedBox(width: 12),
                                            _imageTile(
                                              'assets/images/social/waste_cleanup_1.png',
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                /* ───── Button ───── */
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                          '/community_waste_Support_request',
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Submit Request',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
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
                          const SizedBox(height: 40),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Uplift Others. Stay Connected.',
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
                                  'Give or receive support when it’s needed most, from food drops to friendly check-ins',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    fontFamily: AppFonts.primaryFontFamily,
                                  ),
                                ),

                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Wanna Do Something For Community',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      fontFamily: AppFonts.secondaryFontFamily,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // New section with grids and button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: SizedBox(
                              child: Obx(() {
                                if (controller.isLoading.value) {
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
                                        childAspectRatio: 3 / 3.5,
                                      ),
                                  itemCount: controller.programs.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.programs[index];

                                    return GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: controller.parseHexColor(
                                            item['color'],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              item['icon'],
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 18),
                                            Text(
                                              item['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
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
                          const SizedBox(height: 12),
                          /* ───── Button ───── */
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed('/i_want_to_help');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Continue',
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
                          // --- uplift  end --
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
    );
  }

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
