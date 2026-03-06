import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/apply_for_help/request_mentor_controller.dart';
import '../../functions/fetch_all_territorial.dart';
import '../widgets/drawer.dart';
import '../widgets/searchable_sa.dart';
import '../widgets/searchable_dropdown.dart';
import '../widgets/snack_bar.dart';

class RequestMentor extends StatefulWidget {
  const RequestMentor({super.key});
  @override
  State<RequestMentor> createState() => _RequestMentorState();
}

class _RequestMentorState extends State<RequestMentor> {
  final controller = Get.put(RequestMentorController());
  final dropdown = TerritorialAreaClass();

  @override
  void initState() {
    super.initState();
    dropdown.requestCat();
    controller.fillData();
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
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Request Mentor To Support You',
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
                  ],
                ),
              ),
              // --your address end --

              //--- what are you requesting start --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '3. What Are You Requesting',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        // Pass the controller instance to the function
                        onPressed: () {
                          showGetSearchableBottomSheet(
                            context: context,
                            api: 'apply-for-help/request-types',
                            name: controller.requestName,
                            id: controller.requestId,
                            sheetName: "Select Offers",
                            // displayKey: "",
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Obx(() {
                          final selected = dropdown.userName.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const Icon(Icons.arrow_drop_down, size: 22),
                            ],
                          );
                        }),
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Obx(
                    //         () => DropdownButtonFormField(
                    //           value: controller.selectedRequest.value,
                    //           items:
                    //               dropdown.requestCat.map((city) {
                    //                 return DropdownMenuItem(
                    //                   value: city['id'],
                    //                   child: Text(city['name']),
                    //                 );
                    //               }).toList(),
                    //           onChanged: (val) {
                    //             controller.selectedRequest.value = val as int;
                    //           },
                    //           decoration: const InputDecoration(
                    //             contentPadding: EdgeInsets.symmetric(
                    //               horizontal: 12,
                    //               vertical: 10,
                    //             ),
                    //             filled: true,
                    //             fillColor: AppColors.whiteTextField,
                    //             border: OutlineInputBorder(
                    //               borderSide: BorderSide.none,
                    //               borderRadius: BorderRadius.all(
                    //                 Radius.circular(8),
                    //               ),
                    //             ),
                    //             hintText: 'Select Type',
                    //             hintStyle: TextStyle(
                    //               fontSize: 12,
                    //               color: AppColors.hintColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),

              //--- what are you requesting end --

              //--- advocate start --
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. Do You Have Preferred Type Of Advocate',
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
                          onTap: () => controller.selectInspectionType(1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value == 1
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value == 1
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Male',
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
                          onTap: () => controller.selectInspectionType(2),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value == 2
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value == 2
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Female',
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
                          onTap: () => controller.selectInspectionType(3),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value == 3
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value == 3
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'No Preference',
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

              //--- advocate end --

              //--- description box start --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5. Tell Us Anything You Like us to Know',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => TextField(
                        controller: controller.descriptionController,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText:
                              'eg:Need someone to help explain court process.',
                          hintStyle: const TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorText:
                              controller.descriptionError.value.isEmpty
                                  ? null
                                  : controller.descriptionError.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //---description box end ---

              // ───── Submit Button ─────
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await controller.sendRequest();
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
