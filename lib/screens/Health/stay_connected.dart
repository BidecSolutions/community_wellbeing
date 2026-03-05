import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../controllers/health/stay_connected_controller.dart';
import '../widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/seminar_and_events.dart';

class StayConnected extends StatefulWidget {
  const StayConnected({super.key});

  @override
  State<StayConnected> createState() => _StayConnectedState();
}

class _StayConnectedState extends State<StayConnected> {
  final StayConnectedController controller = Get.put(StayConnectedController());
  @override
  void initState() {
    super.initState();
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
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Stay Connected',
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
              //--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //---share with others--
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Message or Share With Others',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),
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
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/wahnu_group.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Wahnu Chat Group',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // call end
                                  const SizedBox(width: 8),
                                  // not sure start
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed('/not_sure');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFEDBDF),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/health/solo_parent.png',
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 18),
                                            Text(
                                              'Solo Parent Group',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.black,
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
                      const SizedBox(height: 25),
                      SizedBox(child: SeminarAndEvents(category: [2])),
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Center(
                            // Wrap the Text widget with a Center widget
                            child: Text(
                              "Moments Of Change",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                    AppFonts
                                        .secondaryFontFamily, // Use your font
                              ),
                            ),
                          ),
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                        ),
                        items:
                            controller.videoIds.map((videoId) {
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: videoId,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: true,
                                      ),
                                    ),
                                    showVideoProgressIndicator: true,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                      //--- moments of change end --
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
