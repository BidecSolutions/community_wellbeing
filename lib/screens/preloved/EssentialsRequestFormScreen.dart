import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/preloved/prelove_controller.dart';
import 'package:community_app/controllers/preloved/essential_form.dart';
import 'package:community_app/functions/fetch_all_territorial.dart';
import 'package:community_app/models/preloved_model.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/searchable_dropdown.dart';
import 'package:community_app/screens/widgets/searchable_sa.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EssentialsRequestFormScreen extends StatefulWidget {
  const EssentialsRequestFormScreen({super.key});

  @override
  State<EssentialsRequestFormScreen> createState() =>
      _EssentialsRequestFormScreenState();
}

class _EssentialsRequestFormScreenState
    extends State<EssentialsRequestFormScreen> {
  final dropdown = TerritorialAreaClass();
  @override
  void initState() {
    super.initState();
    dropdown.getUserDetails();
  }

  final controller = Get.put(ProductController());

  final essentialForm = Get.put(EssentialForm());

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
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Essentials Request Form',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                const SizedBox(height: 60),
                Text(
                  "You have selected",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final expandedList = controller.expandedSelectedItems;
                  if(controller.expandedSelectedItems.isEmpty){
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50, // background
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Request Sent Successfully',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expandedList.length,
                    itemBuilder: (context, index) {
                      List<Product> items = controller.expandedSelectedItems;
                      final product = expandedList[index];
                      return ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: AppColors.backgroundColor,
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                        ),
                        subtitle: Text(
                          product.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close, size: 16),
                          onPressed: () {
                            controller.removeItem(product);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 8);
                    },
                  );
                }),
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

                      // Phone TextField
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
                                    essentialForm.phoneError.value.isEmpty
                                        ? null // Single space reserves height without showing text
                                        : essentialForm.phoneError.value,
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
                        controller: essentialForm.addressController,
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
                                essentialForm.selectedTA.value = selectedId;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Obx(
                              () => CustomSearchableDropdownSA(
                                selectedValues: essentialForm.selectedTA.value,
                                onItemSelected: (selectedId) {
                                  essentialForm.selectedSA2.value = selectedId;
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '3. Why do you need a device?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: essentialForm.descriptionController,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: 'e.g. “We have no heating”',
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
                              essentialForm.descriptionError.value.isEmpty
                                  ? null
                                  : essentialForm.descriptionError.value,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              essentialForm.productList = controller.indexList;
                              final result = await essentialForm.sendRequest();
                              if (result == true) {
                                controller.clearSelected();
                                final snackBarShow = Snackbar(
                                  title: 'Success',
                                  message:
                                      essentialForm.message.value.toString(),
                                  type: 'success',
                                );
                                snackBarShow.show();
                              } else {
                                final snackBarShow = Snackbar(
                                  title: 'Error',
                                  message:
                                      essentialForm.message.value.toString(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
