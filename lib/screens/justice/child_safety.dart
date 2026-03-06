import 'package:community_app/controllers/justice/safety_awareness.dart';
import 'package:community_app/models/safety_awareness_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import '../widgets/drawer.dart';
// import your controller

class ChildSafety extends StatefulWidget {
  const ChildSafety({super.key});

  @override
  State<ChildSafety> createState() => _ChildSafetyState();
}

class _ChildSafetyState extends State<ChildSafety> {
  final SafetyAwarenessController controller = Get.put(
    SafetyAwarenessController(),
  );

  final SafetyAwarenessModel? selectedCategory = Get.arguments;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategory == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("No Category")),
        body: const Center(child: Text("No category was passed.")),
      );
    }
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
                screenName: selectedCategory!.name,

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


              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        selectedCategory!.innerPageHeading,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        selectedCategory!.innerPageDescription,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppFonts.primaryFontFamily,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      const SizedBox(height: 25),

                      Obx(() {
                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 16 / 22,
                          children:
                              controller.videos.map((video) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        height: 120,
                                        child: YoutubePlayer(
                                          controller: YoutubePlayerController(
                                            initialVideoId: video.videoLink,
                                            flags: const YoutubePlayerFlags(
                                              autoPlay: false,
                                              mute: false,
                                            ),
                                          ),
                                          showVideoProgressIndicator: true,
                                          progressIndicatorColor:
                                              AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      video.videoHeading,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.accentColor,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      video.videoDescription,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily:
                                            AppFonts.secondaryFontFamily,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        );
                      }),
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
