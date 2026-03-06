import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/preloved/donate_appliances.dart';
import 'package:community_app/functions/fetch_all_territorial.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/searchable_dropdown.dart';
import 'package:community_app/screens/widgets/searchable_sa.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/dynamic_bottom_sheet.dart';

class DonateAppliances extends StatefulWidget {
  const DonateAppliances({super.key});

  @override
  State<DonateAppliances> createState() => _DonateAppliancesState();
}

class _DonateAppliancesState extends State<DonateAppliances> {
  final dropdown = TerritorialAreaClass();
  final controller = Get.put(DonateAppliancesController());
  @override
  void initState() {
    super.initState();
    dropdown.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: false,
                  showBackIcon: true,
                  screenName: 'Donate Appliances',
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

                const SizedBox(height: 10),
                Text(
                  "Give a heater, blender, kettle, or other working appliance — we'll match it with a whānau who needs it.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Name TextField
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: dropdown.nameController,
                              readOnly: true,
                              enableInteractiveSelection: false,
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
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              controller: dropdown.contactController,
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              enableInteractiveSelection: false,
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
                                        ? null // Single space reserves height without showing text
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
                      const SizedBox(height: 15),
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '3. Product Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          // Pass the controller instance to the function
                          onPressed: () {
                            showSearchableBottomSheet(
                              context: context,
                              api: 'pre-loved/get-all-category',
                              name: controller.offerName,
                              id: controller.offerId,
                              sheetName: "Select Categories ",
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
                            final selected = controller.offerName.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    selected.isNotEmpty
                                        ? selected
                                        : "Select Categories",
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
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.productNameController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter Product Name',
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
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '4. what are you donating?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.descriptionController,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: 'E.g. “1x Heater',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '5. Upload Photo/video',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
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

                //--- advocate start --
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '6. Condition of Appliance',
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
                                    controller.contactedType.value == 1
                                        ? Colors.transparent
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      controller.contactedType.value == 1
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    'New',
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
                                    controller.contactedType.value == 2
                                        ? Colors.transparent
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      controller.contactedType.value == 2
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    'Used',
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '7. How can it be collected?',
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
                            onTap: () => controller.selectCollectedType(1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.collectedType.value == 1
                                        ? Colors.transparent
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      controller.collectedType.value == 1
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    'Drop off',
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
                            onTap: () => controller.selectCollectedType(2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.collectedType.value == 2
                                        ? Colors.transparent
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      controller.collectedType.value == 2
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    'Pick up',
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        '8. Select Quantity ? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        isDense: true,
                        value:
                            controller.selectedQuantity.value == 0
                                ? null
                                : controller.selectedQuantity.value,
                        items:
                            controller.quantity
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
                SizedBox(height: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
