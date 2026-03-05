import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/real_stories_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class RealStoriesInspire extends StatefulWidget {
  const RealStoriesInspire({super.key});

  @override
  State<RealStoriesInspire> createState() => _RealStoriesInspireState();
}

class _RealStoriesInspireState extends State<RealStoriesInspire> {
  final controller = Get.put(RealStoriesController());
  late Map<String, dynamic> storiesDetails;

  @override
  void initState() {
    super.initState();
    storiesDetails = Get.arguments;
    controller.fetchStories();
  }

  String cleanDescription(String description) {
    String cleaned =
        description
            .replaceAll(RegExp(r'\n\s+'), '\n') // remove indentation
            .trim();

    // Replace only the first "Eligibility Criteria:" with bold + bigger font
    cleaned = cleaned.replaceFirst(
      RegExp(r'Eligibility Criteria:', caseSensitive: false),
      "<span class='eligibility'>Eligibility Criteria:\n</span>",
    );

    return cleaned;
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    // height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Text(
                    storiesDetails['name'] ?? '',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.network(
                    Uri.parse(
                      "${AppSettings.baseUrl}${storiesDetails['cover_image']}",
                    ).toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(Icons.error),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    storiesDetails['heading'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: AppFonts.primaryFontFamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Text(
                    storiesDetails['title'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: AppFonts.primaryFontFamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTextField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Html(
                    data: cleanDescription(storiesDetails['description'] ?? ''),
                    style: {
                      "body": Style(
                        fontSize: FontSize(14),
                        whiteSpace: WhiteSpace.pre,
                        color: AppColors.accentColor,
                      ),
                      ".eligibility": Style(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(16),
                        margin: Margins.only(bottom: 5),
                      ),
                    },
                  ),
                ),
                SizedBox(height: 35),
                Text(
                  'More Stories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 280,
                  child: Obx(
                    () => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 16),
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
                                width: 250,
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

                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    minimumSize: const Size(
                                      double.infinity,
                                      40,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(
                                      '/realStoriesInspire',
                                      arguments: template,
                                      preventDuplicates: false,
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
                            ),
                          ],
                        );
                      },
                    ),
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
