import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/emergency_housing/emergency_housing_controller.dart';


final controller = Get.put(EmergencyHousingController());

class EmergencyHousing extends StatefulWidget {
  const EmergencyHousing({super.key});

  @override
  State<EmergencyHousing> createState() => _EmergencyHousingState();
}

class _EmergencyHousingState extends State<EmergencyHousing> {
  @override
  void initState() {
    super.initState();
    controller.fetchShelter(cityId: 1);
    controller.fetchCity().then((_) {
      // Default selection
      // controller.selectedCity.value = controller.city.first['id'].toString();
      controller.selectCity(controller.selectedCity.value);
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
          child: Column(
            children: [
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Emergency Housing',
                showBottom: true,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New section with grids and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // Full width grid
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/urgent_housing');
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFCDFFDA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/housing/house.png',
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Find Urgent Housing Support',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Fill out this quick form and we’ll connect you with a safe place as soon as possible.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Auto location fetch on page open
                                // LocationListenerWidget(
                                //   onLocationFetched: (Position pos) {
                                //     controller.setLocation(
                                //       pos.latitude,
                                //       pos.longitude,
                                //     );
                                //
                                //     // print("Latitude: ${pos.latitude}, Longitude: ${pos.longitude}");
                                //   },
                                // ),
                                Text(
                                  'Available Shelter',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // --- Issue Details section start ---
                                      const SizedBox(height: 24),
                                      // Row with two dropdowns
                                      Obx(
                                        () => Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Select City',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          AppFonts
                                                              .secondaryFontFamily,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  DropdownButtonFormField<
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
                                                              (
                                                                e,
                                                              ) => DropdownMenuItem(
                                                                value:
                                                                    e['id']
                                                                        .toString(),
                                                                child: Text(
                                                                  e['name'],
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                    onChanged:
                                                        controller.selectCity,
                                                    decoration: const InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AppColors
                                                              .whiteTextField,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 10,
                                                          ),
                                                      hintText: 'Select',
                                                      hintStyle: TextStyle(
                                                        fontSize:
                                                            12, // Adjust font size as needed
                                                        color:
                                                            AppColors
                                                                .hintColor, // Adjust hint color
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                6,
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
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Text(
                                  'Find verified emergency housing options close to you.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    fontFamily: AppFonts.primaryFontFamily,
                                    color: Color(0xFF4C4C4C),
                                  ),
                                ),
                                //--- horizontal list start --
                                const SizedBox(height: 20),

                                Obx(
                                  () => SizedBox(
                                    height: 320,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.topShelters.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            controller.topShelters[index];
                                        return Container(
                                          width: 250,
                                          margin: const EdgeInsets.only(
                                            right: 16,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors
                                                    .white, // Or any light background color
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  AppSettings.baseUrl +
                                                      item['cover_image'],
                                                  height: 140,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                item['name']!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.bed,
                                                    size: 14,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      item['capacity']!,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      maxLines:
                                                          2, // Allows wrapping to 2 lines
                                                      overflow:
                                                          TextOverflow
                                                              .visible, // Optional: allows full text to wrap
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 14,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      item['address']!,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      maxLines:
                                                          2, // Allows wrapping to 2 lines
                                                      overflow:
                                                          TextOverflow
                                                              .visible, // Optional: allows full text to wrap
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final result =
                                                        await controller
                                                            .getSingleShelter(
                                                              id: item['id'],
                                                            );
                                                    Get.toNamed(
                                                      '/shelter_detail',
                                                      arguments: result,
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 8,
                                                        ),
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'View Detail',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                          '/availble_shelter',
                                          arguments: controller.shelterList,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'View All',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                //--- horizontal list end --
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    //--- two grid start ---
                    // New section with grids and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          // Two half width grids 1st
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // call start

                                Expanded(
                                 child:  GestureDetector(
                                    onTap: () async {
                                      final Uri phoneUri = Uri(
                                        scheme: 'tel',
                                        path: '111',
                                      );
                                      if (await canLaunchUrl(phoneUri)) {
                                        await launchUrl(phoneUri);
                                      } else {}
                                    },
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFEDBDF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/health/call.png',
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 18),
                                        Text(
                                          'Call to 111',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ),


                                // call end
                                const SizedBox(width: 16),
                                // not sure start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate or perform action for the first card
                                      Get.toNamed('/someone_know');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFCDFFDA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/housing/call_community.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Call Community Volunteer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // not sure end
                              ],
                            ),
                          ),

                          // Two half width grids 1st end
                        ],
                      ),
                    ),
                    //--- two grid end ---
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
