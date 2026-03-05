import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/culture/language_corner_controller.dart';
import 'package:community_app/models/language_corner.dart';
import 'package:community_app/screens/culture/youtube_player_screen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/save_user_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  final VideoModel video;

  const VideoScreen({super.key, required this.video});
  String getYoutubeId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final RxMap<String, bool> bookmarks = <String, bool>{}.obs;

    if (video.videos.isEmpty) {
      return Scaffold(body: Center(child: Text('No videos available')));
    }
    final controller = Get.put(LanguageCornerController());
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
              GetBuilder<LanguageCornerController>(
                builder: (ctrl) {
                  return SizedBox(
                    width: double.infinity,
                    height: 220,
                    child:
                    // ctrl.ytController.value != null
                    //     ? YoutubePlayer(
                    //       controller: ctrl.ytController.value!,
                    //       showVideoProgressIndicator: true,
                    //       progressIndicatorColor: AppColors.primaryColor,
                    //     )
                    //     :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: video.thumbnailImage,
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
                  final currentVideoId = getYoutubeId(currentVideo.videoLink);
                  return FutureBuilder<double>(
                    future: controller.getProgress(currentVideoId),
                    builder: (context, progressSnapshot) {
                      // final progress = progressSnapshot.data ?? 0.0;

                      return FutureBuilder<bool>(
                        future: controller.isWatched(currentVideoId),
                        builder: (context, watchedSnapshot) {
                          // final watched = watchedSnapshot.data ?? false;

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
                                          (_, _, _) => const Icon(
                                            Icons.image_not_supported,
                                          ),
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

                              trailing:
                              // Icon(
                              //   currentVideo.status == 1
                              //       ? Icons.bookmark
                              //       : Icons.bookmark_outline,
                              //   color:
                              //       isBookmarked.value
                              //           ? AppColors.primaryColor
                              //           : AppColors.primaryColor,
                              // ),
                              Obx(
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
                                // controller.playVideo(currentVideoId);
                                Get.to(
                                  () => YouTubePlayerScreen(
                                    videoId: currentVideoId,
                                    video: video,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
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
