import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/coaches_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Coaches extends StatefulWidget {
  const Coaches({super.key});

  @override
  State<Coaches> createState() => _CoachesState();
}

class _CoachesState extends State<Coaches> {
  final controller = Get.put(CoachController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Score card
                  MyAppBar(
                    showMenuIcon: true,
                    showBackIcon: true,
                    screenName: 'Whānau Learning Coaches',
                    showBottom: false,
                    userName: false,
                    showNotificationIcon: false,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Connect with experienced whānau coaches who understand your journey — here to guide, check in, and support your learning path.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.errorMessage.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    }
                    if (controller.coaches.isEmpty) {
                      return Center(child: Text("No coaches available"));
                    }

                    return ListView.separated(
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.coaches.length,
                      itemBuilder: (context, index) {
                        final coach = controller.coaches[index];

                        return Container(
                          // padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.whiteTextField,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.titleHeight,
                            leading: CircleAvatar(
                              radius: 20,
                              child: Image.network(
                                "${AppSettings.baseUrl}${coach.image}",
                                width: 40,
                                height: 40,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      coach.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 30),

                                    Text(
                                      "\$${coach.slots.isNotEmpty ? coach.slots.first['fee'] : 0}/hr",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ), // default style
                                    children: [
                                      TextSpan(text: "Experience: "),
                                      TextSpan(
                                        text: "${coach.experience}+ yrs",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ), // default style
                                    children: [
                                      // for line break
                                      TextSpan(text: "Qualification: "),
                                      TextSpan(
                                        text: coach.qualification,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Book Now
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 100,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                          '/coachProfile',
                                          arguments: coach,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Book Now",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
