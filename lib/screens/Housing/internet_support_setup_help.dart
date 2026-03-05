import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/internet_support_setup_help_controller.dart';
import '../widgets/drawer.dart';

class InternetSupportSetupHelp extends StatelessWidget {
  InternetSupportSetupHelp({super.key});
  final controller = Get.put(InternetSupportSetupHelpController());
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
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Internet Support or Setup Help',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),

              /* ─────────── App-bar End ─────────── */
              //--- form start ---
              //-- Your Details start --
              // ───── Section Label ─────
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1. Your Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // Name TextField
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => TextField(
                              controller: controller.nameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // No leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'Your Name',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.nameError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.nameError.value,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Phone TextField
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => TextField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Only numbers
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'\s'),
                                ), // No spaces
                              ],
                              decoration: InputDecoration(
                                hintText: 'Phone No',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.phoneError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.phoneError.value,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // -- your detail end --
              // -- your address start --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '2. Home Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Full-width address text field
                    Obx(
                      () => TextField(
                        controller: controller.addressController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^\s'),
                          ), // No leading space
                        ],
                        decoration: InputDecoration(
                          hintText: 'Your Address',
                          hintStyle: TextStyle(
                            fontSize: 12, // Adjust font size as needed
                            color: AppColors.hintColor, // Adjust hint color
                          ),
                          errorText:
                              controller.addressError.value.isEmpty
                                  ? ' ' // Single space reserves height without showing text
                                  : controller.addressError.value,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          filled: true,
                          fillColor: AppColors.whiteTextField,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),

                    // 3 dropdowns in a row
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              value:
                                  controller.selectedTA.value.isEmpty
                                      ? null
                                      : controller.selectedTA.value,
                              items:
                                  controller.ta
                                      .map(
                                        (city) => DropdownMenuItem(
                                          value: city,
                                          child: Text(city),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                controller.selectedTA.value = val ?? '';
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'TA',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              value:
                                  controller.selectedSA2.value.isEmpty
                                      ? null
                                      : controller.selectedSA2.value,
                              items:
                                  controller.sa2
                                      .map(
                                        (region) => DropdownMenuItem(
                                          value: region,
                                          child: Text(region),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                controller.selectedSA2.value = val ?? '';
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'SA2',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // --your address end --

              // --- support you need start--
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. What Support Do You Need?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              "Apply for free/low-cost internet (Wi-Fi/Fibre)",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.hintColor,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: controller.isPointOneChecked.value,
                            onChanged: controller.togglePointOne,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              "Schedule a home Wi-Fi/device setup visit",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.hintColor,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: controller.isPointTwoChecked.value,
                            onChanged: controller.togglePointTwo,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),

              // --- support you need end --

              // ───── Submit Button ─────
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.validateFields();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.primaryFontFamily,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              //--- form end ---
            ],
          ),
        ),
      ),
    );
  }
}
