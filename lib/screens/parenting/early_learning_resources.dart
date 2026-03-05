import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../app_settings/settings.dart';
import '../../controllers/parenting/early_learning_resource_controller.dart';
import '../widgets/drawer.dart';


class EarlyLearningResources extends StatefulWidget {
  const EarlyLearningResources({super.key});

  @override
  State<EarlyLearningResources> createState() => _EarlyLearningResourcesState();
}

class _EarlyLearningResourcesState extends State<EarlyLearningResources> {

  final EarlyLearningResourceController controller = Get.put(EarlyLearningResourceController());
  @override
  void initState() {
    super.initState();
    controller.fetchLearnPages();
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
                screenName: 'Early learning resources',
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
              //--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'Learning by Age Group',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 25),
                      //--- drop down box start --
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: controller.selectedRightValue.value,
                                    hint: const Text("Select Age"),
                                    onChanged: (newValue) {
                                      controller.selectedRightValue.value =
                                      newValue!;
                                    },
                                    items:
                                    controller.rightDropdownItems
                                        .map<DropdownMenuItem<String>>((
                                        String value,
                                        ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    })
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      //--- drop down box end --

                      const SizedBox(height: 30),
                      Text(
                        ' Learn Through Play',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 30),
                      //--- Track Growth & Milestones end --

                      Obx(() {
                        return Column(
                          children: controller.apiPage.map((item) {
                            return GestureDetector(
                              onTap: () {
                                controller.resourcePage(id: item.id, name: item.label);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),

                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(AppSettings.baseUrl + item.images,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Heading
                                    Text(
                                      item.label,
                                      style: TextStyle(
                                        fontFamily: AppFonts.secondaryFontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Description
                                    Text(
                                      item.des,
                                      style: TextStyle(
                                        fontFamily: AppFonts.secondaryFontFamily,
                                        fontSize: 13,
                                        color: Color(0xFF4C4C4C),
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
