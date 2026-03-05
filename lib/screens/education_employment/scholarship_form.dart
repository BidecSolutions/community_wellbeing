import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/scholarship_form.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart' hide box;
import 'package:community_app/screens/widgets/searchable_dropdown.dart';
import 'package:community_app/screens/widgets/searchable_sa.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScholarshipForm extends StatefulWidget {
  const ScholarshipForm({super.key});

  @override
  State<ScholarshipForm> createState() => _ScholarshipFormState();
}

class _ScholarshipFormState extends State<ScholarshipForm> {
  final controller = Get.put(ScholarshipFormController());
  @override
  void initState() {
    super.initState();
    controller.nameController.text = box.read('name') ?? '';
    controller.phoneController.text = box.read('phone') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Scholorship Foam',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 30),
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
                            TextField(
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
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Phone TextField
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                      TextField(
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
                      const SizedBox(height: 20),

                      //ta & sa2
                      Row(
                        children: [
                          Expanded(
                            child: CustomSearchableDropdown(
                              onItemSelected: (selectedId) {
                                controller.selectedTA.value = selectedId;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Obx(
                              () => CustomSearchableDropdownSA(
                                selectedValues: controller.selectedTA.value,
                                onItemSelected: (selectedId) {
                                  controller.selectedSA2.value = selectedId;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '3. Upload Proof of Identity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(
                            controller.identityFilePath,
                          ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.identityFilePath.value.isEmpty
                                  ? 'Upload Proof of Identity'
                                  : 'Uploaded: ${controller.identityFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '4. Upload Academic Transcript or NCEA Results',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(
                            controller.transcriptFilePath,
                          ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.transcriptFilePath.value.isEmpty
                                  ? 'Upload Academic Transcript or NCEA Results'
                                  : 'Uploaded: ${controller.transcriptFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '5.Upload Proof of Enrollment (or Offer Letter)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(
                            controller.enrollmentFilePath,
                          ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.enrollmentFilePath.value.isEmpty
                                  ? 'Upload Proof of Enrollment (or Offer Letter)'
                                  : 'Uploaded: ${controller.enrollmentFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '6. Proof of Income',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(
                            controller.incomeFilePath,
                          ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.incomeFilePath.value.isEmpty
                                  ? 'Upload Proof of Income'
                                  : 'Uploaded: ${controller.incomeFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '7. Personal Statement or Cover Letter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(
                            controller.statementFilePath,
                          ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.statementFilePath.value.isEmpty
                                  ? 'Upload Personal Statement or Cover Letter'
                                  : 'Uploaded: ${controller.statementFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '8. Upload Curriculum Vitae (CV)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // adjust as needed
                  child: Obx(() {
                    return InkWell(
                      onTap:
                          () => controller.pickImageFile(controller.cvFilePath),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.whiteTextField,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.cvFilePath.value.isEmpty
                                  ? 'Upload Curriculum Vitae (CV)'
                                  : 'Uploaded: ${controller.cvFilePath.value.split('/').last}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4C4C4C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await controller.sendRequestHostEvent();
                        if (result == true) {
                          final snackBarShow = Snackbar(
                            title: 'Success',
                            message: controller.message.value.toString(),
                            type: 'success',
                          );
                          snackBarShow.show();
                        } else {
                          final snackBarShow = Snackbar(
                            title: 'Error',
                            message: controller.message.value.toString(),
                            type: 'error',
                          );
                          snackBarShow.show();
                        }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
