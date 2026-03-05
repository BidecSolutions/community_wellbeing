import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/health/healthy_living_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart' hide box;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/health/step_counter_controller.dart';

class HealthyLivingPrevention extends StatefulWidget {
  const HealthyLivingPrevention({super.key});

  @override
  State<HealthyLivingPrevention> createState() =>
      _HealthyLivingPreventionState();
}

class _HealthyLivingPreventionState extends State<HealthyLivingPrevention> {
  final controller = Get.put(HealthyLivingController());
  final controllerHealth = Get.put(StepCounterController());

  @override
  void initState() {
    super.initState();
    controller.fetchSuggestion(id: 0);
  }

  Color getDarkerShade(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
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
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Healthy Living Prevention',
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
              //--- steps count start --
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.loginGradientStart,
                          AppColors.loginGradientEnd,
                        ],
                        stops: [0.0, 0.6],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Obx(() {
                        double progress = (controllerHealth.stepCount.value / 10000).clamp(0.0, 1.0);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 14,
                                backgroundColor: Color(0xFFEEEBEB),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFEEEBEB),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "10000",
                                      style: TextStyle(
                                        fontFamily: AppFonts.secondaryFontFamily,
                                        fontSize: 12,
                                        color: Color(0xFF4C4C4C)
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      int.tryParse(box.read('stepCounter')?.toString() ?? '0')?.toString() ?? '0',
                                      style: TextStyle(
                                        fontFamily: AppFonts.secondaryFontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "steps",
                                      style: TextStyle(
                                        fontFamily: AppFonts.secondaryFontFamily,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),

              //--- steps count end --

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: tabButtonsListView(),
              ),
              const SizedBox(height: 24),
              // Title
              Center(
                child: Text(
                  "Healthy Meal Suggestions",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Dropdown
              Obx(
                () => Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 0,
                        value:
                            controller.selectedDropdown.value.isEmpty
                                ? null
                                : controller.selectedDropdown.value,
                        items:
                            controller.dropdownItems
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppFonts.primaryFontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        onChanged: (value) async {
                          controller.selectedDropdown.value = value ?? "";
                          final selectedCategory = controller
                              .categorySuggestionList
                              .firstWhere(
                                (element) => element.categoryName == value,
                              );
                            await controller.fetchSuggestionCategoryDetails(
                              id: selectedCategory.id,
                            );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                return Column(
                  children:
                      controller.contentData.map((section) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: section["color"],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Transform.rotate(
                                      angle: 0.785398,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        color: getDarkerShade(section["color"]),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      section["title"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        fontFamily:
                                            AppFonts.secondaryFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ...List.generate(section["items"].length, (
                                  index,
                                ) {
                                  var item = section["items"][index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${index + 1}. ${item['name']}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            item['desc'] ?? "",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.textColor,
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,

                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabButtonsListView() {
    return Obx(
      () => SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.suggestionList.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final suggestionItem = controller.suggestionList[index];
            bool isSelected = controller.selectedTab.value == index;

            return GestureDetector(
              onTap: () async {
                controller.selectedTab.value = index;
                controller.fetchSuggestion(id: suggestionItem.id);
                controller.fetchSuggestionCategories(id: suggestionItem.id);
                final selectedSuggestionId =
                    controller.suggestionList[index].id;
                await controller.fetchSuggestionCategories(
                  id: selectedSuggestionId,
                );

                if (controller.categorySuggestionList.isNotEmpty) {
                  controller.selectedDropdown.value =
                      controller.categorySuggestionList[0].categoryName;
                  final firstCategoryId =
                      controller.categorySuggestionList[0].id;

                  await controller.fetchSuggestionCategoryDetails(
                    id: firstCategoryId,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? const Color(0xFF5A189A) : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  suggestionItem.name,
                  style: TextStyle(
                    color:
                        isSelected ? const Color(0xFF5A189A) : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
