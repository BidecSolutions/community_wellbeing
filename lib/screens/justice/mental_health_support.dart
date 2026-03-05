import 'package:community_app/controllers/justice/mental_health_support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import '../widgets/drawer.dart';

class MentalHealthSupport extends StatelessWidget {
  MentalHealthSupport({super.key});
  final MentalHealthSupportController mentalHealthSupport = Get.put(Get.find());

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
              Obx(
                () => MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: mentalHealthSupport.pageHeading.value,
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(height: 40),
                      // Obx(
                      //   () => Text(
                      //     mentalHealthSupport.pageHeading.value,
                      //     textAlign: TextAlign.center,
                      //     style: Theme.of(
                      //       context,
                      //     ).textTheme.titleLarge!.copyWith(
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: AppFonts.secondaryFontFamily,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 12),
                      Obx(
                        () => Text(
                          mentalHealthSupport.pageDescription.value,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontFamily: AppFonts.primaryFontFamily,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Obx(
                        () => GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 1,
                          childAspectRatio: 16 / 13,
                          children:
                              mentalHealthSupport.apiVideoLinks.map((video) {

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        height: 170,
                                        child: YoutubePlayer(
                                          controller: YoutubePlayerController(
                                            initialVideoId: video.videoLink,
                                            flags: const YoutubePlayerFlags(
                                              autoPlay: false,
                                              mute: false,
                                            ),
                                          ),
                                          showVideoProgressIndicator: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      video.label,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                    ),
                                    Text(
                                      video.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.accentColor,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
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
