import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/profile/change_password_controller.dart';

final box = GetStorage();

class ChangePassword extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    String type = "";
    String showMessage = "";
    IconData iconData = Icons.info;
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
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Change Password',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    //--- form start ---
                    // -- your Name start --
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),

                          // Full-width old pass text field
                          Obx(
                                () => TextField(
                              controller: controller.oldPassController,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Old Password',
                                hintStyle:  TextStyle(
                                  fontSize: 12,         // Adjust font size as needed
                                  color: AppColors.hintColor,
                                  // Adjust hint color
                                ),

                                errorText: controller.oldPassError.value.isEmpty
                              ? ' ' // Single space reserves height without showing text
                                : controller.oldPassError.value,
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
                          // old pass end
                          const SizedBox(height:3),

                          // Full-width new pass text field
                          Obx(
                                () => TextField(
                                  obscureText: true,
                              controller: controller.newPassController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // No leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                hintStyle:  TextStyle(
                                  fontSize: 12,         // Adjust font size as needed
                                  color: AppColors.hintColor,   // Adjust hint color
                                ),
                                errorText: controller.newPassError.value.isEmpty
                                    ? ' ' // Single space reserves height without showing text
                                    : controller.newPassError.value,

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
                          // new pass end

                          const SizedBox(height: 3),

                          // Full-width confirm pass text field
                          Obx(
                                () => TextField(
                                  obscureText: true,
                              controller: controller.confirmPassController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // No leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.hintColor,
                                ),
                                errorText: controller.confirmPassError.value.isEmpty
                                    ? ' ' // Single space reserves height without showing text
                                    : controller.confirmPassError.value,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to Forgot Password screen or handle the logic
                                // Get.toNamed('/forgot-password'); // Example using GetX route
                              },
                              child: Text(
                                'Forgot Password ?',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.primaryFontFamily,
                                  color: AppColors.hintColor,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await controller.changePassword();

                            if (result == true) {
                              type = "Success";
                              showMessage = controller.message.value.toString();
                              iconData = Icons.check_box;
                            } else {
                              type = "Error";
                              showMessage = controller.message.value.toString();
                              iconData = Icons.error;
                            }

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          iconData,
                                          size: 50.0,
                                          color: Colors.amber,
                                        )
                                            .animate()
                                            .scaleXY(begin: 0.5, end: 1.0, duration: 300.ms)
                                            .then()
                                            .shakeY(),
                                        const SizedBox(height: 15.0),
                                         Text(type,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                         Text(showMessage,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            if (type == "Success")
                                            ElevatedButton(
                                              onPressed: () async {
                                                logoutUser(token: box.read('token'));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.deepPurpleAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                              ),
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                              ),
                                              child: Text(
                                                        type == 'Success' ? 'NO' : 'OK',
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
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
              )


            ],
          ),
        ),
      ),
    );
  }

}
