import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/disability/article_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_settings/fonts.dart';


class Articles extends StatefulWidget {
  const Articles({super.key});

  @override

  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final ArticleController controller = Get.put(ArticleController());
  @override
  void initState() {
    super.initState();
    controller.fetchCategory();
    controller.fetchArticles();
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
                screenName: 'Disability Support Hub',
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

              const SizedBox(height: 20),
              Obx(() => SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.tabs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) =>
                    const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final item = controller.tabs[index];
                      return Obx(() {
                        final isSelected = controller.selectedIndex.value == index;
                        return GestureDetector(
                          onTap: () {
                            controller.filterArticles(item['id']);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              item['name'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
                  SizedBox(height: 10,),
                Obx((){
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.filter.length,
                    itemBuilder: (context, index) {
                      final article = controller.filter[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            '/disability_awareness',
                            arguments: article,
                          );
                        },
                        child: ResourceCard(object: article),
                      );
                    },
                  );
                })
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final Map<String, dynamic> object;
  const ResourceCard({super.key, required this.object});

  final imagePath = AppSettings.baseUrl;

  @override
  Widget build(BuildContext context) {
    final imageUrl = "$imagePath${object['image'] ?? ''}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (object['image'] != null && object['image'].toString().isNotEmpty)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(height: 180, color: Colors.grey[300]),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      object['name']?.toString() ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      object['title']?.toString() ?? "",
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Icon(Icons.north_east, color: AppColors.primaryColor),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

