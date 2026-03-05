import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/parenting/helpline_schedule_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/searchable_sa.dart';
import '../widgets/searchable_dropdown.dart';
import '../widgets/snack_bar.dart';

class HelplineSchedule extends StatefulWidget {
  const HelplineSchedule({super.key});

  @override
  State<HelplineSchedule> createState() => _HelplineScheduleState();
}

final url = "${AppSettings.baseUrl}housing/territorial-area";

class _HelplineScheduleState extends State<HelplineSchedule> {
  final controller = Get.put(HelplineScheduleController());
  @override
  void initState() {
    super.initState();
    controller.getUserName();
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
                screenName: 'Contact Us',
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ───── Heading ───── */
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Round-the-clock phone or text support for crisis situations like abuse, addiction, grief, and mental health.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppFonts.primaryFontFamily,
                              color: Color(0xFF4C4C4C),
                            ),
                          ),
                          //--- form start ---
                          // ───── Section Label ─────
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'What type of help you are looking for',
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
                              horizontal: 16.0,
                            ),
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
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Your Name',
                                          hintStyle: TextStyle(
                                            fontSize:
                                                12, // Adjust font size as needed
                                            color:
                                                AppColors
                                                    .hintColor, // Adjust hint color
                                          ),

                                          contentPadding:
                                              const EdgeInsets.symmetric(
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
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: controller.phoneController,
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
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
                                            fontSize:
                                                12, // Adjust font size as needed
                                            color:
                                                AppColors
                                                    .hintColor, // Adjust hint color
                                          ),

                                          contentPadding:
                                              const EdgeInsets.symmetric(
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
                          // -- your detail end --
                          // -- your description start --
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),

                                // Full-width address text field
                                TextField(
                                  controller: controller.descriptionController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r'^\s'),
                                    ), // No leading space
                                  ],
                                  decoration: InputDecoration(
                                    hintText:
                                        'A bit description of that you are looking for',
                                    hintStyle: TextStyle(
                                      fontSize:
                                          12, // Adjust font size as needed
                                      color:
                                          AppColors
                                              .hintColor, // Adjust hint color
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
                          // --your description end --

                          //--- your zip code and help for start --
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Select Help For',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.secondaryFontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 38,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  showGetSearchableBottomSheet(
                                                    context: context,
                                                    api: 'parenting/for-help',
                                                    name:
                                                        controller
                                                            .forHelpSelect,
                                                    id: controller.requestId,
                                                    sheetName: "Select Type",
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                      ),
                                                ),
                                                child: Obx(() {
                                                  final selected =
                                                      controller
                                                          .forHelpSelect
                                                          .value;
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          selected.isNotEmpty
                                                              ? selected
                                                              : "Select Type",
                                                          style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14,
                                                          ),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //--- your zip code and help for end --

                          // -- your address start --
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomSearchableDropdown(
                                        onItemSelected: (selectedId) {
                                          controller.selectedTA.value =
                                              selectedId;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Obx(
                                        () => CustomSearchableDropdownSA(
                                          selectedValues:
                                              controller.selectedTA.value,
                                          onItemSelected: (selectedId) {
                                            controller.selectedSA2.value =
                                                selectedId;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
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
                                      fontSize:
                                          12, // Adjust font size as needed
                                      color:
                                          AppColors
                                              .hintColor, // Adjust hint color
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
                          // --your address end --

                          //--- button section --
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Call Now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: AppFonts.primaryFontFamily,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final result =
                                          await controller
                                              .submitEmergencyRequest();
                                      if (result == true) {
                                        final snackBarShow = Snackbar(
                                          title: 'Success',
                                          message:
                                              controller.message.value
                                                  .toString(),
                                          type: 'success',
                                        );
                                        snackBarShow.show();
                                      } else {
                                        final snackBarShow = Snackbar(
                                          title: 'Error',
                                          message:
                                              controller.message.value
                                                  .toString(),
                                          type: 'error',
                                        );
                                        snackBarShow.show();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Submit Request',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: AppFonts.primaryFontFamily,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //-- button section end --

                          //--- form end--
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
