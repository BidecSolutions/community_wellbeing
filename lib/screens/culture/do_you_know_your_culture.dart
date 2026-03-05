import 'package:community_app/controllers/culture/do_you_know_your_culture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../widgets/drawer.dart';

class DoYouKnowYourCulture extends StatelessWidget {
  final String title;
  // final int index = 0;

  DoYouKnowYourCulture(this.title, {super.key});

  final DoYouKnowYourCultureController controller = Get.put(
    DoYouKnowYourCultureController(),
  );

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
                screenName: title,
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
                        'Take a quick quiz to see how much you know about your heritage, culture, and local history.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.primaryFontFamily,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 25),

                      const SizedBox(height: 25),

                      // Progress Bar
                      Obx(() {
                        int totalGroups = controller.currentChecklistGroups.entries.length;
                        int answeredGroups = 0;

                        controller.currentChecklistGroups.entries.forEach((entry) {
                          int gStart = controller.currentChecklistGroups.entries
                              .takeWhile((e) => e.key != entry.key)
                              .fold(0, (sum, e) => sum + e.value.length);

                          bool isAnswered = entry.value.asMap().entries.any((item) {
                            int idx = gStart + item.key;
                            return idx < controller.isCheckedList.length &&
                                controller.isCheckedList[idx] == true;
                          });

                          if (isAnswered) answeredGroups++;
                        });

                        double progress = totalGroups > 0 ? answeredGroups / totalGroups : 0.0;

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

                      // Checklist Display
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
                            int groupIndex = 0;
                            // progress based on how many questions are answered
                            int totalGroups = controller.currentChecklistGroups.entries.length;
                            int answeredGroups = controller.currentChecklistGroups.entries
                                .where((entry) {
                              int gStart = controller.currentChecklistGroups.entries
                                  .takeWhile((e) => e.key != entry.key)
                                  .fold(0, (sum, e) => sum + e.value.length);
                              return controller.isCheckedList.length > gStart &&
                                  controller.isCheckedList[gStart] != false;
                            }).length;

                            return Column(
                              children: controller.currentChecklistGroups.entries.map((entry) {
                                int groupStartIndex = controller.currentChecklistGroups.entries
                                    .takeWhile((e) => e.key != entry.key)
                                    .fold(0, (sum, e) => sum + e.value.length);

                                int currentGroup = groupIndex;
                                groupIndex++;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question ${currentGroup + 1}:',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(
                                      entry.key,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 2),
                                    ...entry.value.asMap().entries.map((item) {
                                      int globalIndex = groupStartIndex + item.key;

                                      if (globalIndex >= controller.isCheckedList.length) {
                                        return const SizedBox();
                                      }

                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(item.value)),
                                          Obx(
                                                () => Radio<int>(
                                              value: item.key, // this option's index
                                              groupValue: controller.isCheckedList
                                                  .asMap()
                                                  .entries
                                                  .where((e) =>
                                              e.key >= groupStartIndex &&
                                                  e.key < groupStartIndex + entry.value.length &&
                                                  e.value == true)
                                                  .isNotEmpty
                                                  ? controller.isCheckedList
                                                  .asMap()
                                                  .entries
                                                  .where((e) =>
                                              e.key >= groupStartIndex &&
                                                  e.key < groupStartIndex + entry.value.length &&
                                                  e.value == true)
                                                  .first
                                                  .key - groupStartIndex
                                                  : null,
                                              onChanged: (int? value) {
                                                if (value != null) {
                                                  // uncheck all in this group first
                                                  for (int i = groupStartIndex;
                                                  i < groupStartIndex + entry.value.length;
                                                  i++) {
                                                    if (i < controller.isCheckedList.length) {
                                                      controller.isCheckedList[i] = false;
                                                    }
                                                  }
                                                  // check selected
                                                  controller.isCheckedList[groupStartIndex + value] = true;
                                                  controller.isCheckedList.refresh();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    const SizedBox(height: 12),
                                  ],
                                );
                              }).toList(),
                            );
                          }),

                        ],
                      ),

                      const SizedBox(height: 20),

                      // Button
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/find_a_provider');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Talk to specialist',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
