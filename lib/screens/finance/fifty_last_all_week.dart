import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';

class FiftyLastAllWeek extends StatelessWidget {
  FiftyLastAllWeek({super.key});

  final List<Map<String, String>> videos = [
    {'id': 'vJabNEwZIuc', 'label': 'Master Financial Literacy '},
    {'id': '-FP7IVNN4bI', 'label': 'Money Management Tips '},
    {'id': 'HBkj_pD7RHA', 'label': 'The 1% Rule'},
    {'id': '-bqeNE1DOzA', 'label': 'Budgeting Tips'},
    {'id': 'Qo9YlbaESas', 'label': 'How to Trick Your Brain Into Saving Money'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: const Color(0xFFF5F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: true,
                showBackIcon: true,
                showBottom: false,
                userName: false,
                screenName: "Watch: How to make \n\$50 last all week",
              ),

              //--- video section start --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Main full-width video
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 200, // fixed height for main video
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: videos[0]['id']!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      videos[0]['label']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Heading for more videos
                    Text(
                      'More Videos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grid of remaining videos with labels
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio:
                            16 / 16, // adjusted aspect ratio to fit height
                        children:
                            videos.sublist(1).map((video) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      height:
                                          120, // fixed height for grid videos
                                      child: YoutubePlayer(
                                        controller: YoutubePlayerController(
                                          initialVideoId: video['id']!,
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
                                    video['label']!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
