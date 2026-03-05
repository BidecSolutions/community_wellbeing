import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/overcrowding_waste_support_request_controller.dart';
import '../widgets/drawer.dart';

class OverCrowdingSupportRequest extends StatelessWidget {
  OverCrowdingSupportRequest({super.key});
  final controller = Get.put(OvercrowdingWasteSupportRequestController());

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
                screenName: 'Overcrowding Support Request',
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
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
              // --your address end --

              //--- applying for start --
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '3. Applying For',
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
                child: Obx(
                  () => Row(
                    children: [
                      // Join Cleaning Group
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => controller.selectInspectionType(
                                ' Temporary housing',
                              ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          ' Temporary housing'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            ' Temporary housing'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  ' Temporary housing',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Room dividers, hygiene kits
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => controller.selectInspectionType(
                                'Room dividers, hygiene kits',
                              ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Room dividers, hygiene kits'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Room dividers, hygiene kits'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Room dividers, hygiene kits',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Emergency housing
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => controller.selectInspectionType(
                                'Emergency housing',
                              ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Emergency housing'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Emergency housing'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Emergency housing',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //--- applying for end --
              //--- current living situation start --
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. Current Living Situation',
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
                  vertical: 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ── Row 1 ── */
                    Obx(
                      () => Row(
                        children: [
                          // Number of People
                          Expanded(
                            child: TextField(
                              controller: controller.peopleController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // no leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'Number of People',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.peopleError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.peopleError.value,
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Number of Bedrooms
                          Expanded(
                            child: TextField(
                              controller: controller.bedroomsController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Number of Bedrooms',
                                hintStyle: TextStyle(
                                  fontSize: 12, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.bedroomsError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.bedroomsError.value,
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    /* ── Row 2 ── */
                    Obx(
                      () => Row(
                        children: [
                          // Children/Elderly
                          Expanded(
                            child: TextField(
                              controller: controller.childrenElderlyController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText:
                                    'Do you have children or elders in the home?',
                                hintStyle: TextStyle(
                                  fontSize: 10, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.childrenError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.childrenError.value,
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Relationship
                          Expanded(
                            child: TextField(
                              controller: controller.relationController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText:
                                    'Relationship to others in the household',
                                hintStyle: TextStyle(
                                  fontSize: 10, // Adjust font size as needed
                                  color:
                                      AppColors.hintColor, // Adjust hint color
                                ),
                                errorText:
                                    controller.relationError.value.isEmpty
                                        ? ' ' // Single space reserves height without showing text
                                        : controller.relationError.value,
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //--- current living situation end --
              // --- upload image start--
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '5. Upload Image',
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
                    onTap: controller.pickImageFile,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: AppColors.whiteTextField, // Same as fillColor
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
                            controller.imageFilePath.value.isEmpty
                                ? 'Upload Image/Video'
                                : 'Uploaded: ${controller.imageFilePath.value.split('/').last}',
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
              // --- upload image end--
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
