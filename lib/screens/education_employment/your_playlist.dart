import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/learning_module_controller.dart';
import 'package:community_app/models/learning_model.dart';
import 'package:community_app/screens/education_employment/play_video.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/save_user_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourPlaylist extends StatelessWidget {
  final PlaylistVideoModel video;
  YourPlaylist({super.key, required this.video});

  final RxMap<String, bool> bookmarks = <String, bool>{}.obs;

  @override
  Widget build(BuildContext context) {
    if (video.videos.isEmpty) {
      return Scaffold(body: Center(child: Text('No videos available')));
    }
    final controller = Get.put(LearningModuleController());
    final firstVideo = video.videos.first;
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: video.thumbnailDescription,
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),
              const SizedBox(height: 20),

              /// YouTube Player
              GetBuilder<LearningModuleController>(
                builder: (ctrl) {
                  return SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${AppSettings.baseUrl}${video.thumbnailImage}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              /// Current Video Description
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstVideo.videoHeading,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          firstVideo.videoDescription,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                          maxLines: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'Other Videos',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.secondaryFontFamily,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: video.videos.length,
                itemBuilder: (context, index) {
                  final currentVideo = video.videos[index];
                  final currentVideoId = currentVideo.videoLink;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://img.youtube.com/vi/$currentVideoId/0.jpg',
                              width: 80,
                              height: 60,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (_, _, _) =>
                                      const Icon(Icons.image_not_supported),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        '${index + 1}. ${currentVideo.videoHeading}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: AppFonts.primaryFontFamily,
                        ),
                      ),
                      subtitle: Text(
                        currentVideo.videoDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: AppFonts.primaryFontFamily,
                        ),
                      ),

                      trailing: Obx(
                        () => IconButton(
                          onPressed: () async {
                            final result =
                                await SaveUserVideo(
                                  module: 12,
                                  videoId: currentVideo.id,
                                ).fetchAllEvents();
                            bookmarks[currentVideoId] = result;
                          },
                          icon: Icon(
                            bookmarks[currentVideoId] == true
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            color:
                                bookmarks[currentVideoId] == true
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor,
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          () =>
                              PlayVideo(videoId: currentVideoId, video: video),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
