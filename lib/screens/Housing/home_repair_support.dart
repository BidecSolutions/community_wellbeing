import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart' hide box;
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/home_repair_support_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/searchable_sa.dart';
import '../widgets/searchable_dropdown.dart';
import '../widgets/snack_bar.dart';

class HomeRepairSupport extends StatefulWidget {
  const HomeRepairSupport({super.key});

  @override
  State<HomeRepairSupport> createState() => _HomeRepairSupportState();
}

class _HomeRepairSupportState extends State<HomeRepairSupport> {
  final userName = TextEditingController();
  final userContact = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.fetchTerritorialArea();
    controller.fetchRepairingIssues();
    userName.text = box.read('name');
    userContact.text = box.read('phone');
  }

  final controller = Get.put(HomeRepairSupportController());

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
                screenName: 'Home Repair Support',
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
                              controller: userName,
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
                              controller: userContact,
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
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              value:
                                  controller.selectedOwned.value.isEmpty
                                      ? null
                                      : controller.selectedOwned.value,
                              items:
                                  controller.owned
                                      .map(
                                        (country) => DropdownMenuItem(
                                          value: country,
                                          child: Text(country),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                controller.selectedOwned.value = val ?? '';
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
                                hintText: 'Select Ownership Type',
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

              // --- upload image start--
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '3. Upload Image',
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

              // --- urgency and type of issue start --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Issue Details section start ---
                    const SizedBox(height: 24),
                    // Row with two dropdowns
                    Obx(
                      () => Row(
                        children: [
                          // Type of Issue
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '4. Type of Issue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: 45,
                                  child: OutlinedButton(
                                    // Pass the controller instance to the function
                                    onPressed: () {
                                      showGetSearchableBottomSheet(
                                        context: context,
                                        api: 'housing/home-repairing-issue',
                                        name: controller.requestName,
                                        id: controller.requestId,
                                        sheetName: "Select Offers",
                                        displayKey: "reparing_issues",
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      side: const BorderSide(
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                    ),
                                    child: Obx(() {
                                      final selected =
                                          controller.requestName.value;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              selected.isNotEmpty
                                                  ? selected
                                                  : "Select Types",
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            size: 22,
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Urgency Level
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '5.Select',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value:
                                      controller
                                              .selectedUrgencyLevel
                                              .value
                                              .isEmpty
                                          ? null
                                          : controller
                                              .selectedUrgencyLevel
                                              .value,
                                  items:
                                      controller.urgencyLevels
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: controller.selectUrgency,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.whiteTextField,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    hintText: 'Urgency',
                                    hintStyle: TextStyle(
                                      fontSize:
                                          12, // Adjust font size as needed
                                      color:
                                          AppColors
                                              .hintColor, // Adjust hint color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Show description box if "Other" is selected
                    Obx(
                      () =>
                          controller.showDescription.value
                              ? TextField(
                                controller: controller.descriptionController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText: 'Describe the issue',
                                  filled: true,
                                  fillColor: AppColors.whiteTextField,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),
                    ),

                    // --- Issue Details section end ---
                  ],
                ),
              ),

              // --- urgency and type of issue end --

              // ───── Submit Button ─────
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await controller.homeRepairingService();
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

              //--- form end ---
            ],
          ),
        ),
      ),
    );
  }
}
