import 'package:community_app/screens/doctor/booking_foam.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../app_settings/settings.dart';
import '../../controllers/doctor/profile_controller.dart';
import '../widgets/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
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
              /* â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ App-bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ */
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: '',
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


              /* â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ App-bar End â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-- gradient section start here ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.loginGradientStart,
                            AppColors.loginGradientEnd,
                          ],
                          stops: [0.0, 0.6],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                AppSettings.baseUrl +
                                    controller.doctorImage.value,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () => Text(
                              controller.doctorSpec.value,
                              style: const TextStyle(
                                color: AppColors.hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(
                            () => Text(
                              controller.doctorName.value,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //--- gradient section end here ---
                    const SizedBox(height: 20),
                    Text(
                      controller.doctorDescription.value,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: AppFonts.primaryFontFamily,
                        color: Colors.black,
                      ),
                    ),
                    // ---experience start--
                    const SizedBox(height: 16),

                    Center(
                      child: Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _toggleButton(
                                label: 'Paid',
                                isSelected: controller.isPaid.value,
                                onTap: () => controller.isPaid.value = true,
                              ),
                              const SizedBox(width: 8),
                              _toggleButton(
                                label: 'Free',
                                isSelected: !controller.isPaid.value,
                                onTap: () => controller.isPaid.value = false,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    Obx(() {
                      if (controller.isLoading.value == true) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final filteredList =
                          controller.apiOPD
                              .where(
                                (item) =>
                                    item.opdType ==
                                    (controller.isPaid.value ? 1 : 2),
                              )
                              .toList();

                      if (filteredList.isEmpty) {
                        return Center(child: Text("No doctors available"));
                      }
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        separatorBuilder: (_, _) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.day,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            AppFonts.secondaryFontFamily,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: 'Total Patient: '),
                                          TextSpan(
                                            text: item.patient.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: 'Fee: '),
                                          TextSpan(
                                            text: item.fee.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.hospitalName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            AppFonts.secondaryFontFamily,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: 'Distance: '),
                                          TextSpan(
                                            text: '0.5km',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    controller.checkValue.contains(item.id)
                                        ? Text(
                                          "Booked",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                        : SizedBox(
                                          width: 100,
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final res = await controller
                                                  .getDate(day: item.day);
                                              if (!context.mounted) return;
                                              showDialog(
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return LayoutBuilder(
                                                    builder: (
                                                      context,
                                                      constraints,
                                                    ) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        content: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                16.0,
                                                              ),
                                                          width:
                                                              constraints
                                                                  .maxWidth *
                                                              0.9,
                                                          height:
                                                              constraints
                                                                  .maxHeight *
                                                              0.6,
                                                          child: SingleChildScrollView(
                                                            child: BookingForm(
                                                              hospitalName:
                                                                  item.hospitalName,
                                                              doctorFee:
                                                                  item.fee,
                                                              day: item.day,
                                                              from: item.start,
                                                              end: item.end,
                                                              dates: res,
                                                              slotId: item.id,
                                                              doctorID:
                                                                  item.doctorID,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              "Book Now",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
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

Widget _toggleButton({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child:
        isSelected
            ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(label, style: const TextStyle(color: Colors.black)),
            ),
  );
}
