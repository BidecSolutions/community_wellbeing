import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/coaches_controller.dart';
import 'package:community_app/models/coaches_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachProfile extends StatefulWidget {
  const CoachProfile({super.key});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  late Coach coach;
  @override
  void initState() {
    super.initState();
    coach = Get.arguments;
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score card
                  MyAppBar(
                    showMenuIcon: true,
                    showBackIcon: true,
                    screenName: 'Profile',
                    showBottom: false,
                    userName: false,
                    showNotificationIcon: false,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.loginGradientStart,
                          AppColors.loginGradientEnd,
                        ],
                        stops: [0.0, 0.6],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            AppSettings.baseUrl + coach.image,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          coach.qualification,
                          style: const TextStyle(
                            color: AppColors.hintColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          coach.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(coach.description),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===== Coach Info (Experience & Fee) =====
                        SizedBox(height: 20),

                        // ===== Slots List =====
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: coach.slots.length,
                          itemBuilder: (context, index) {
                            var slot = coach.slots[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Coach info (Experience + Fee)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: "Experience: "),
                                          TextSpan(
                                            text: "${coach.experience}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: "Fee: "),
                                          TextSpan(
                                            text: "${slot['fee']}/hr",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),

                                // Slot info (Start + End)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: "Start: "),
                                          TextSpan(
                                            text: "${slot['start_at']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: "End: "),
                                          TextSpan(
                                            text: "${slot['end_at']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),

                                // Day
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: "Day: "),
                                          TextSpan(
                                            text: "${slot['day']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(width: 50),
                                    SizedBox(
                                      height: 35,
                                      width: 120,
                                      child: Obx(() {
                                        final booked = controller.isSlotBooked(
                                          slot['id'],
                                        );
                                        final loading = controller
                                            .isSlotLoading(slot['id']);

                                        return ElevatedButton(
                                          onPressed:
                                              loading || booked
                                                  ? null
                                                  : () {
                                                    controller.bookSlot(
                                                      slot['id'],
                                                      "2025-09-01",
                                                    );
                                                  },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                booked
                                                    ? Colors.green
                                                    : AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                          ),
                                          child:
                                              loading
                                                  ? SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                  : Text(
                                                    booked
                                                        ? "Booked"
                                                        : "Book Now",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),

                                // Separator between slots
                                if (index != coach.slots.length - 1) ...[
                                  SizedBox(height: 10),
                                  Divider(
                                    thickness: 1.2,
                                    color: AppColors.primaryColor.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
