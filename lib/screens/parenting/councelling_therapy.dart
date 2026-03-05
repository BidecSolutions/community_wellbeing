import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../controllers/parenting/counseling_therapy_controller.dart';
import '../../controllers/parenting/parenting_support_program_controller.dart';
import '../widgets/drawer.dart';

class CounselingTherapy extends StatelessWidget {
  CounselingTherapy({super.key});

  final CounselingTherapyController controller = Get.put(
    CounselingTherapyController(),
  );
  final ParentingSupportController controller1 = Get.put(
    ParentingSupportController(),
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
              Obx(
                () => MyAppBar(
                  showMenuIcon: false,
                  showBackIcon: true,
                  screenName: controller1.pageHeading.value,
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                  profile: true,
                ),

              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),//--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),

                      Obx(
                        () => Text(
                          controller1.pageDescription.value,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontFamily: AppFonts.primaryFontFamily,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(() {
                        if (controller.videos.isEmpty ||
                            controller1.apiVideoLinks.isEmpty) {
                          return Text('No videos available');
                        }

                        // final video = controller.videos.first;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId:
                                      controller1.apiVideoLinks.first.id,
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                ),
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // --- Who it’s for--
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  controller1.extraHeading.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: <Widget>[
                                  for (var desc in controller1.descriptions)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "• ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Expanded(
                                            child: Text(
                                              desc,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.hintColor,
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
                                          Get.toNamed('/find_a_provider');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Book Session',
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
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
                          ],
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
