import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/emergency_housing/shelter_request_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/snack_bar.dart';

class ShelterRequest extends StatelessWidget {
  ShelterRequest({super.key});
  final controller = Get.put(ShelterRequestController());

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
                screenName: 'Request To Say',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
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
                                    FilteringTextInputFormatter.digitsOnly,// Only numbers
                                 // No spaces
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

              // -- your no of people start --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '2. No of people',
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
                            controller: controller.noOfPeopleController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // only digits
                            ],
                            decoration: InputDecoration(
                              hintText: 'No of people Eg: 2',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: AppColors.hintColor,
                              ),
                              errorText:
                              controller.noOfPeopleError.value.isEmpty
                                  ? ' '
                                  : controller.noOfPeopleError.value,
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

                  ],
                ),
              ),
              // --your no of people end --


              //--- description start--

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '3. Notes',
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
                        controller: controller.descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4, // or null for dynamic height
                        minLines: 3, // Minimum height
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^\s'), // No leading spaces
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: 'e.g., urgently looking for housing',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.hintColor,
                          ),
                          errorText: controller.descriptionError.value.isEmpty
                              ? ' '
                              : controller.descriptionError.value,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: AppColors.whiteTextField,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )



                  ],
                ),
              ),
              // --your address end --
              //description end --

              // ───── Submit Button ─────
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool result = await controller.sendRequest();
                      if (result == true) {
                        final snackBarShow = Snackbar(
                          title: 'Success',
                          message: controller.message.value.toString(),
                          type: 'success',
                        );
                        snackBarShow.show();
                      } else {
                        final snackBarShow = Snackbar(
                          title: 'Failed',
                          message: controller.message.value.toString(),
                          type: 'error',
                        );
                        snackBarShow.show();
                      }
                      controller.sendRequest();
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
