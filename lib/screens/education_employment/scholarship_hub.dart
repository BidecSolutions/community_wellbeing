import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/scholarship_hub_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScholarshipHub extends StatefulWidget {
  const ScholarshipHub({super.key});

  @override
  State<ScholarshipHub> createState() => _ScholarshipHubState();
}

class _ScholarshipHubState extends State<ScholarshipHub> {
  final controller = Get.put(ScholarshipHubController());
  @override
  void initState() {
    super.initState();
    controller.fetchLevel();
    controller.fetchFunds();
    controller.fetchScholarships();
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
                  screenName: 'Your Scholarship Hub',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 10),
                Text(
                  'Discover and apply for scholarships that match your background, goals, and qualifications.',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => showLevelBottomSheet(context, controller),
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
                                      controller.selectedLevel.value?['name'] ??
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

                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => showFundingBottomSheet(context, controller),
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
                                      controller.selectedFunds.value?['name'] ??
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
                  if (controller.scholarships.isEmpty) {
                    return Center(child: Text('No ScholarShips Found'));
                  }
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.scholarships.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.4,
                        ),

                    itemBuilder: (context, index) {
                      final template = controller.scholarships[index];
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              template['name'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: buildText(
                              label: 'Deadline:',
                              value: template['dead_line'] ?? '',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: buildText(
                              label: 'Level:',
                              value: template['level_name'] ?? '',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: buildText(
                              label: 'Funding:',
                              value: template['fund_type'] ?? '',
                            ),
                          ),
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
                                  '/scholarshipHubDetails',
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

void showLevelBottomSheet(
  BuildContext context,
  ScholarshipHubController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredCategories =
      <Map<String, dynamic>>[].obs;

  filteredCategories.assignAll(controller.level);

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
                      filteredCategories.assignAll(controller.level);
                    } else {
                      final filtered =
                          controller.level
                              .where(
                                (cat) => cat['name']
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
                          title: Text(item['name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedLevel.value = item;
                            Get.back();
                            controller.filterScholarships();
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

void showFundingBottomSheet(
  BuildContext context,
  ScholarshipHubController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredCategories =
      <Map<String, dynamic>>[].obs;

  filteredCategories.assignAll(controller.funds);

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
                      filteredCategories.assignAll(controller.funds);
                    } else {
                      final filtered =
                          controller.funds
                              .where(
                                (cat) => cat['name']
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
                          title: Text(item['name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedFunds.value = item;
                            Get.back();
                            controller.filterScholarships();
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

Widget buildText({
  required String label,
  required String value,
  double labelWidth = 60, // adjust width as needed
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: labelWidth,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}
