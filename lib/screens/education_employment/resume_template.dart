import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/resume_template_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumeTemplate extends StatefulWidget {
  const ResumeTemplate({super.key});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final controller = Get.put(ResumeTemplateController());
  @override
  void initState() {
    super.initState();
    controller.fetchClass();
    controller.fetchResume();
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
                  screenName: 'Customize Resume Templates',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 10),
                Text(
                  'Choose a style that fits your goals and start editing on your own device.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () =>
                                  showCategoryBottomSheet(context, controller),
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Color(0xFF908E8E),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      controller
                                              .selectedCategory
                                              .value?['category_name'] ??
                                          "Select Category",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  }

                  if (controller.resume.isEmpty) {
                    return Center(child: Text('No Resume found'));
                  }
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.resume.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.4,
                        ),

                    itemBuilder: (context, index) {
                      final template = controller.resume[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFBAC1D9),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: Image.network(
                                Uri.parse(
                                  "${AppSettings.baseUrl}${template['cover_image']}",
                                ).toString(),
                                fit: BoxFit.cover,
                                // width: double.infinity,
                                height: 150,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              template['title'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              template['description'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // const Spacer(),
                          // Button
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
                                  '/professionalResume',
                                  arguments: template,
                                );
                              },
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontFamily: AppFonts.primaryFontFamily,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCategoryBottomSheet(
  BuildContext context,
  ResumeTemplateController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredCategories =
      <Map<String, dynamic>>[].obs;

  filteredCategories.assignAll(controller.category);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Column(
              children: [
                const Text(
                  "Select Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Search field
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    if (query.isEmpty) {
                      filteredCategories.assignAll(controller.category);
                    } else {
                      final filtered =
                          controller.category
                              .where(
                                (cat) => cat['category_name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                      filteredCategories.assignAll(filtered);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // List of categories
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: scrollController,
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final item = filteredCategories[index];
                        return ListTile(
                          leading: const Icon(Icons.category_outlined),
                          title: Text(item['category_name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedCategory.value = item;
                            controller.filterByCategory(item['id']);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
