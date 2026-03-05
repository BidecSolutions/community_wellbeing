import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../app_settings/settings.dart';
import '../../controllers/doctor/find_a_provider_controller.dart';
import '../../controllers/doctor/profile_controller.dart';
import '../widgets/drawer.dart';

import '../widgets/searchable_hospitals.dart';

class FindAProvider extends StatefulWidget {
  const FindAProvider({super.key});

  @override
  State<FindAProvider> createState() => _FindAProviderState();
}

class _FindAProviderState extends State<FindAProvider> {
  final FindAProviderController controller = Get.put(FindAProviderController());
  final ProfileController doctorProfileController = Get.put(
    ProfileController(),
  );
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.fetchCity();
    controller.findDoctors();
    controller.selectedHospital.value = "";
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Find A Doctor',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            // Row with two dropdowns
                            Row(
                              children: [
                                Expanded(
                                  // Removed Obx from here
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Select City',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.secondaryFontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Obx(
                                        // Moved Obx to wrap only the DropdownButtonFormField
                                        () => SizedBox(
                                          height: 50,
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            value:
                                                controller
                                                        .selectedCity
                                                        .value
                                                        .isEmpty
                                                    ? null
                                                    : controller
                                                        .selectedCity
                                                        .value,
                                            items:
                                                controller.city
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value:
                                                            e['id'].toString(),
                                                        child: Text(e['name']),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: controller.selectCity,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  AppColors.whiteTextField,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 10,
                                                  ),
                                              hintText: 'Select City',
                                              hintStyle: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.hintColor,
                                              ),
                                              // border: OutlineInputBorder(
                                              //   borderSide: const BorderSide(
                                              //     color: Colors.grey,
                                              //     width: 1.2,
                                              //   ),
                                              //   borderRadius:
                                              //       BorderRadius.circular(6),
                                              // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                      AppColors.backgroundColor,
                                                  width: 1.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).primaryColor,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Select Hospitals',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.secondaryFontFamily,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: OutlinedButton(
                                          // Pass the controller instance to the function
                                          onPressed: () {
                                            showSearchableBottomSheet(
                                              context: context,
                                              api:
                                                  'doctor/get-all-hospital-and-clinic',
                                              name: controller.requestName,
                                              id: controller.requestId,
                                              sheetName: "Select Hospital",
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            side: const BorderSide(
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                            ),
                                          ),
                                          child: Obx(() {
                                            final selected =
                                                controller.requestName.value;
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    selected.isNotEmpty
                                                        ? selected
                                                        : "Select Hospital",
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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

                                      // Obx(
                                      //   () => SearchableDropdownHospitals(
                                      //     onItemSelected: (selectedId) {
                                      //       controller.selectedHospital.value =
                                      //           selectedId;
                                      //       final hospitalID = int.parse(
                                      //         selectedId,
                                      //       );
                                      //       controller.findDoctors(
                                      //         hospitalID: hospitalID,
                                      //       );
                                      //     },
                                      //     selectedValues:
                                      //         controller.selectedCity.value,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //--- Paid Section ---
                      // Removed the outer Obx from here
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: TextField(
                              onChanged:
                                  (query) => controller.filterProviders(query),
                              decoration: InputDecoration(
                                labelText: 'Search providers',
                                hintText: 'Enter name or keyword',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Obx(() {
                            // This Obx is correct because it wraps the dynamic list
                            final list = controller.filteredProviders;
                            final isLoadingMore =
                                controller.isLoadingMore.value;
                            return Column(
                              children: [
                                ...list.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final item = entry.value;
                                  return Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Colors.grey[200],
                                            child: ClipOval(
                                              child: Image.network(
                                                AppSettings.baseUrl +
                                                    item.image,
                                                width: 56,
                                                height: 56,
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return Image.asset(
                                                    'assets/images/dr_img.png',
                                                    width: 56,
                                                    height: 56,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                                Text(
                                                  item.major,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Happy Patient :',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: '150',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  item.venue,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Show Reviews',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              SizedBox(height: 25),
                                              SizedBox(
                                                width: 100,
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    doctorProfileController
                                                        .doctorSchedule(
                                                          id: item.id,
                                                          name: item.name,
                                                          description: item.des,
                                                          experience:
                                                              item.experience,
                                                          image: item.image,
                                                          spec: item.major,
                                                          hospitalID:
                                                              controller
                                                                  .selectedHospital
                                                                  .value,
                                                          object: [],
                                                        );
                                                    doctorProfileController
                                                        .doctorSchedule(
                                                          id: item.id,
                                                          name: item.name,
                                                          description: item.des,
                                                          experience:
                                                              item.experience,
                                                          image: item.image,
                                                          spec: item.major,
                                                          hospitalID:
                                                              controller
                                                                  .selectedHospital
                                                                  .value,
                                                          object: [item],
                                                        );
                                                    Get.toNamed(
                                                      '/doctor_profile',
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Proceed",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (index < list.length - 1)
                                        const Divider(),
                                    ],
                                  );
                                }),
                                if (isLoadingMore)
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ],
                      ),
                      //--- content end here ---
                    ],
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
