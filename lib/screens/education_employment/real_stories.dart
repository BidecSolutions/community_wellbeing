import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/real_stories_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealStories extends StatefulWidget {
  const RealStories({super.key});

  @override
  State<RealStories> createState() => _RealStoriesState();
}

class _RealStoriesState extends State<RealStories> {
  final controller = Get.put(RealStoriesController());
  @override
  void initState() {
    super.initState();
    controller.fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                // * ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Real Stories That Inspire',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 10),
                Text(
                  'Hear from learners like you – how they overcame challenges, found their path, and took the next step.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.stories.length,
                    itemBuilder: (context, index) {
                      final template = controller.stories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Image.network(
                              Uri.parse(
                                "${AppSettings.baseUrl}${template['cover_image']}",
                              ).toString(),
                              fit: BoxFit.cover,
                              // width: double.infinity,
                              height: 150,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.error),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Text(
                              template['heading'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              template['title'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 8.0,
                          //   ),
                          //   child: buildText(
                          //     label: 'Deadline:',
                          //     value: template['dead_line'] ?? '',
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 8.0,
                          //   ),
                          //   child: buildText(
                          //     label: 'Level:',
                          //     value: template['level_name'] ?? '',
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 8.0,
                          //   ),
                          //   child: buildText(
                          //     label: 'Funding:',
                          //     value: template['fund_type'] ?? '',
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(
                                  '/realStoriesInspire',
                                  arguments: template,
                                );
                              },
                              child: Text(
                                "Watch ${template['heading']} Story",
                                style: TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontFamily: AppFonts.primaryFontFamily,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
