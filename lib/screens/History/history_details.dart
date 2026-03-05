import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/History/history_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/history_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/foam_widget.dart';

class HistoryFoams extends StatefulWidget {
  HistoryFoams({super.key});

  @override
  State<HistoryFoams> createState() => _HistoryFoamsState();
}

class _HistoryFoamsState extends State<HistoryFoams> {
  final HistoryController controller = Get.put(HistoryController());

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
              Obx(() {
                return MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: controller.categoryName.value,
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                );
              }),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(controller.allTabs.length, (
                        index,
                      ) {
                        final category = controller.allTabs[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectCategory(categoryId: category.id);
                            controller.selectedCategory.value = category.id;
                            controller.fetchFoam(category.id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedCategory.value ==
                                          category.id
                                      ? AppColors.primaryColor
                                      : AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color:
                                    controller.selectedCategory.value ==
                                            category.id
                                        ? AppColors.primaryColor
                                        : AppColors.backgroundColor,
                              ),
                            ),
                            child: Text(
                              category.formName,
                              style: TextStyle(
                                color:
                                    controller.selectedCategory.value ==
                                            category.id
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight:
                                    controller.selectedCategory.value ==
                                            category.id
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),

                  Obx(() {
                    if (controller.requests.isEmpty) {
                      return const Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.requests.length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> foamDetails =
                            controller.requests[index];
                        final RxMap<dynamic, dynamic> foamItems =
                            controller.foamData;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FoamWidget(
                            foamDetails: foamDetails,
                            foamItems: foamItems,
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
