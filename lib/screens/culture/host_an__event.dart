import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/culture/host_an_event_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart' hide box;
import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:community_app/screens/widgets/searchable_dropdown.dart';
import 'package:community_app/screens/widgets/searchable_sa.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HostAnEvent extends StatefulWidget {
  const HostAnEvent({super.key});

  @override
  State<HostAnEvent> createState() => _HostAnEventState();
}

class _HostAnEventState extends State<HostAnEvent> {
  final controller = Get.put(HostAnEventController());
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
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Host an Event',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),
              const SizedBox(height: 20),
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
                      '2. Pickup Address',
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
                    const Text(
                      '3. Event Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: OutlinedButton(
                              // Pass the controller instance to the function
                              onPressed: () {
                                showSearchableBottomSheet(
                                  context: context,
                                  api: 'culture/get-culture-event-type',
                                  name: controller.requestName,
                                  id: controller.requestId,
                                  sheetName: "Select Housing Support",
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              child: Obx(() {
                                final selected = controller.requestName.value;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selected.isNotEmpty
                                            ? selected
                                            : "Select Housing Support",
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. Hosting  Type',
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
                      // in home
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => controller.selectInspectionType('Location'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Location'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Location'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Location',
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
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () => controller.selectInspectionType('Virtual'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Virtual'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Virtual'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Virtual',
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
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '5. Preferred Date/Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Date Box
                    Expanded(
                      child: Obx(
                        () => TextFormField(
                          readOnly: true,
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: Get.context!,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              controller.selectedDate.value = pickedDate;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'dd/mm/yyyy',
                            filled: true,
                            fillColor: AppColors.whiteTextField,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                          controller: TextEditingController(
                            text:
                                controller.selectedDate.value == null
                                    ? ''
                                    : DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(controller.selectedDate.value!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Time Box
                    Expanded(
                      child: Obx(
                        () => TextFormField(
                          readOnly: true,
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: Get.context!,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              controller.selectedTime.value = pickedTime;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: '9:00 AM',
                            filled: true,
                            fillColor: AppColors.whiteTextField,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                          controller: TextEditingController(
                            text:
                                controller.selectedTime.value == null
                                    ? ''
                                    : controller.selectedTime.value!.format(
                                      Get.context!,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '6. Upload Flyer',
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
    );
  }
}
