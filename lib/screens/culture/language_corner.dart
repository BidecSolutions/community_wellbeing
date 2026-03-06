import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/culture/language_corner_controller.dart';
import 'package:community_app/screens/culture/video_player.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LanguageCorner extends StatelessWidget {
  const LanguageCorner({super.key});

  /// Extracts YouTube video ID from full video URL
  String getYoutubeId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final LanguageCornerController ctrl = Get.put(LanguageCornerController());

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              showMenuIcon: false,
              showBackIcon: true,
              screenName: 'Language Corner',
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

            const SizedBox(height: 16),
            GetBuilder<LanguageCornerController>(
              builder: (ctrl) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      ctrl.languages.map((lang) {
                        final isSelected = ctrl.selectedLanguage.value == lang;

                        return GestureDetector(
                          onTap: () => ctrl.changeLanguage(lang),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              lang,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<LanguageCornerController>(
                  builder: (ctrl) {
                    final filteredVideos =
                        ctrl.videos
                            .where(
                              (v) => v.languageId == ctrl.selectedLanguageId,
                            )
                            .toList();
                    if (filteredVideos.isEmpty ||
                        ctrl.languages.isEmpty ||
                        ctrl.selectedLanguageId == 0) {
                      return Center(
                        child: CircularProgressIndicator(),
                        // Text('No videos or languages available'),
                      );
                    }
                    return GridView.builder(
                      itemCount: filteredVideos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        final video = filteredVideos[index];
                        final thumbnail = video.thumbnailImage;
                        final title = video.thumbnailDescription;

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VideoScreen(video: video));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Thumbnail with Play Icon
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    thumbnail,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, _, _) => const Icon(
                                          Icons.image_not_supported,
                                        ),
                                  ),
                                ),

                                /// Text Info
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.secondaryFontFamily,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),

                                      // Placeholder meta info. Replace with real fields if available.
                                      _buildMetaText(
                                        'Language:',
                                        ctrl.languages.isNotEmpty
                                            ? ctrl.languages[video.languageId %
                                                ctrl.languages.length]
                                            : 'Unknown',
                                      ),
                                      _buildMetaText(
                                        'Videos:',
                                        video.videos.length.toString(),
                                      ),
                                      _buildMetaText(
                                        'Status:',
                                        video.status == 1
                                            ? 'Active'
                                            : 'Inactive',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: AppFonts.secondaryFontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 11,
                fontFamily: AppFonts.secondaryFontFamily,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
