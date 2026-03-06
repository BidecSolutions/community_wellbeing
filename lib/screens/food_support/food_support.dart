import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/food_support/food_support_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_navigation.dart';


class FoodSupport extends StatefulWidget {
  const FoodSupport({super.key});

  @override
  State<FoodSupport> createState() => _FoodSupportState();
}

class _FoodSupportState extends State<FoodSupport> {
  final FoodSupportController controller = Get.put(FoodSupportController());

  @override
  void initState() {
    super.initState();
    controller.fetchFoodBank();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Scrollable AppBar + Search
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: false,
                showBackIcon: true,
                showBottom: false,
                profile: true,
                userName: false,
                screenName: "Food Support",
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),

              Padding(
                padding: EdgeInsetsGeometry.only(left: 20, right: 20, top: 40),
                child: Column(
                  children: [
                    Text(
                      "Request A Food Parcel Or Voucher",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => Get.toNamed('/request_a_food_parcel'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFEDBDF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Get Help With Food Or Grocery Support",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.secondaryFontFamily,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Need Help With Meals? Request A Food Parcel Or Voucher — Quick And Private.",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Help Near You",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // DropdownButtonFormField<int>(
                    //   isDense: true,
                    //   value:
                    //   controller2.selectedQuantity.value == 0
                    //       ? null
                    //       : controller2.selectedQuantity.value,
                    //   items:
                    //   controller2.quantity
                    //       .map(
                    //         (sizeValue) => DropdownMenuItem<int>(
                    //       value: sizeValue,
                    //       child: Text(sizeValue.toString()),
                    //     ),
                    //   )
                    //       .toList(),
                    //   onChanged:
                    //       (val) =>
                    //   controller2.selectedQuantity.value = val ?? 0,
                    //   decoration: const InputDecoration(
                    //     filled: true,
                    //     fillColor: AppColors.whiteTextField,
                    //     border: InputBorder.none,
                    //     enabledBorder: InputBorder.none,
                    //     contentPadding: EdgeInsets.symmetric(
                    //       horizontal: 12,
                    //       vertical: 6,
                    //     ),
                    //     hintText: 'Select Address',
                    //     hintStyle: TextStyle(
                    //       fontSize: 6,
                    //       color: AppColors.hintColor,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 28),
                    Obx(() {
                      if (controller.foodBankList.isEmpty) {
                        return const Center(child: Text("No food banks available"));
                      }
                      return ListView.builder(
                        itemCount: controller.foodBankList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final bank = controller.foodBankList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSupportCenterCard(bank),
                              const Text("Timing:", style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 10),
                              buildSlotsTable(bank['slots'] ?? []),

                              Divider(),
                            ],
                          );
                        },
                      );

                    })
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
Widget buildSupportCenterCard(Map<String, dynamic> center) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📍 ${center['name'] ?? '' }',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        SizedBox(height: 8),

        Text("Location:", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(center['address'] ?? ''),
        //
        // SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () {
        //     // Add location logic (e.g., open Google Maps)
        //     // doctorController.findDoctors(
        //     //   userLat: doctorController.latitude.value,
        //     //   userLon: doctorController.longitude.value,
        //     //   radiusKm: doctorController.radius,
        //     // );
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.deepPurple,
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     elevation: 0, // no shadow
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(6),
        //     ),
        //   ),
        //   child: Text(
        //     "Get Location",
        //     style: TextStyle(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 12,
        //       fontFamily: AppFonts.primaryFontFamily,
        //       color: AppColors.whiteTextField,
        //     ),
        //   ),
        // ),

        const SizedBox(height: 12),
        const Text("Services:", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(center['service'] ?? ''),
        const SizedBox(height: 12),
        const Text("Contact:", style: TextStyle(fontWeight: FontWeight.w600)),
        Text('${center['contact'] ?? ''} '),
      ],
    ),
  );
}

Widget buildSlotsTable(List<dynamic> slots) {

  return Table(
    border: TableBorder.all(color: Colors.grey.shade300),
    columnWidths: const {
      0: FlexColumnWidth(3),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
    },
    children: [
      ...slots.map<TableRow>((slot) {
        return TableRow(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(slot['day'] ?? ''),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(slot['start_time'] ?? ''),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(slot['end_time'] ?? ''),
              ),
            ),
          ],
        );
      }),
    ],
  );
}
