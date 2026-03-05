import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/screens/widgets/app_bar.dart' hide box;
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart' hide box;
import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:community_app/screens/widgets/searchable_dropdown.dart';
import 'package:community_app/screens/widgets/searchable_sa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/food_support/food_support_controller.dart';
import '../widgets/snack_bar.dart';

class RequestAFoodParcel extends StatefulWidget {
  const RequestAFoodParcel({super.key});

  @override
  State<RequestAFoodParcel> createState() => _RequestAFoodParcelState();
}

class _RequestAFoodParcelState extends State<RequestAFoodParcel> {
  @override
  void initState() {
    super.initState();
    controller.nameController.text = box.read('name') ?? '';
    controller.phoneController.text = box.read('phone') ?? '';
  }
  final controller = Get.put(FoodSupportController());
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
                screenName: 'Request a Food Parcel or Voucher',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),

              Padding(
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
                      '2. Home Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      '3. Who Is This For ? ',
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
                            height: 50,
                            child: OutlinedButton(
                              // Pass the controller instance to the function
                              onPressed: () {
                                showSearchableBottomSheet(
                                  context: context,
                                  api: 'food-support/get-food-parcel-category',
                                  name: controller.requestName,
                                  id: controller.requestId,
                                  sheetName: "Select Parcel For",
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
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
                                            : "Select Parcel For",
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '4. Number of total Person ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      isDense: true,
                      value: controller.selectedQuantity.value == 0 ? null : controller.selectedQuantity.value,
                      items: controller.quantity
                              .map(
                                (sizeValue) => DropdownMenuItem<int>(
                                  value: sizeValue,
                                  child: Text(sizeValue.toString()),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (val) =>
                              controller.selectedQuantity.value = val ?? 0,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.whiteTextField,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        hintText: 'Select Quantity',
                        hintStyle: TextStyle(
                          fontSize: 6,
                          color: AppColors.hintColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '5. How Would Like To Proceed ?',
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
                              () => controller.selectInspectionType('Delivery'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Delivery'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Delivery'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Delivery',
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
                              () => controller.selectInspectionType('Pickup'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedInspectionType.value ==
                                          'Pickup'
                                      ? Colors.transparent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    controller.selectedInspectionType.value ==
                                            'Pickup'
                                        ? Colors.black
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: FittedBox(
                                child: Text(
                                  'Pickup',
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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        '6. Tell us anything you’d like us to know',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controller.descriptionController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^\s'),
                          ), // No leading space
                        ],
                        decoration: InputDecoration(
                          hintText: 'e.g., allergies, infant needs',
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
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await controller.sendFoodSupportRequest();
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
