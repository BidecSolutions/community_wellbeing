import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../controllers/parenting/early_learning_resource_controller.dart';
import '../widgets/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResourceVideo extends StatelessWidget {
  ResourceVideo({super.key});

  final EarlyLearningResourceController controller =
      Get.find<EarlyLearningResourceController>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    final String name = args['name'];


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
                screenName: name,
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: controller.apiResourcePage.isNotEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 25),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children:
                      controller.apiResourcePage.map((video) {
                            YoutubePlayerController ytController =
                                YoutubePlayerController(
                                  initialVideoId: video.id.toString(),
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                );
                            return SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 56) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YoutubePlayer(
                                    controller: ytController,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor:
                                        AppColors.primaryColor,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    video.title,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ) : const Center(
                  child: Text(
                    'No video found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
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
