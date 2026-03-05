import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/first_job_kit.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstJobKit extends StatefulWidget {
  const FirstJobKit({super.key});

  @override
  State<FirstJobKit> createState() => _FirstJobKitState();
}

class _FirstJobKitState extends State<FirstJobKit> {
  final controller = Get.put(FirstJobKitController());
  @override
  void initState() {
    super.initState();
    controller.fetchClass();
    controller.fetchJobKit();
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
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'My First Job Kit',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),

                      // Intro text
                      Text(
                        'Your simple, step-by-step guide to getting job-ready.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.primaryFontFamily,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 25),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:
                                    () => showCategoryBottomSheet(
                                      context,
                                      controller,
                                    ),
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
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
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

                      // Dropdown for Age Group Selection
                      // Obx(
                      //   () => Container(
                      //     padding: const EdgeInsets.symmetric(horizontal: 12),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton<int>(
                      //         value: controller.selectedRightIndex.value,
                      //         onChanged: (int? newIndex) {
                      //           if (newIndex != null) {
                      //             controller.selectedRightIndex.value =
                      //                 newIndex;
                      //           }
                      //         },
                      //         items:
                      //             controller.rightDropdownItems
                      //                 .asMap()
                      //                 .entries
                      //                 .map(
                      //                   (entry) => DropdownMenuItem<int>(
                      //                     value: entry.key,
                      //                     child: Text(entry.value),
                      //                   ),
                      //                 )
                      //                 .toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 25),

                      // Progress Bar
                      Obx(() {
                        if (controller.isLoading.value) {
                          return CircularProgressIndicator();
                        }
                        if (controller.jobKit.isEmpty) {
                          return Center(child: Text('No Job Kit Found.'));
                        }

                        double progress = controller.progress;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300],
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: progress.clamp(0.0, 1.0),
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Bad",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Average",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Good",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Excellent",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "${controller.rightDropdownItems[controller.selectedRightIndex.value]} Development Checklist",
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          const SizedBox(height: 12),

                          // Checklist logic
                          Obx(() {
                            return Column(
                              children:
                                  controller.jobKit.asMap().entries.map((
                                    entry,
                                  ) {
                                    final int index = entry.key;
                                    final Map<String, dynamic> item =
                                        entry.value;

                                    // Correct key from API
                                    final String text =
                                        item['points']?.toString() ?? '';

                                    if (index >=
                                        controller.isCheckedList.length) {
                                      return const SizedBox.shrink();
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${index + 1}. $text',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Obx(() {
                                          return Checkbox(
                                            value:
                                                controller.isCheckedList[index],
                                            onChanged: (bool? value) {
                                              if (value != null) {
                                                controller
                                                        .isCheckedList[index] =
                                                    value;
                                              }
                                            },
                                          );
                                        }),
                                      ],
                                    );
                                  }).toList(),
                            );
                          }),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Button
                    ],
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

void showCategoryBottomSheet(
  BuildContext context,
  FirstJobKitController controller,
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
                            controller.fetchJobKit(
                              kitId: item['id'],
                            ); // refresh kit when category changes
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
