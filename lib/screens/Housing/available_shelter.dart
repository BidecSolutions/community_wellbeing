import 'package:community_app/app_settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/emergency_housing/emergency_housing_controller.dart';
import '../widgets/drawer.dart';

final controller = Get.put(EmergencyHousingController());
final RxList<Map<String, dynamic>> shelterList =
    Get.arguments as RxList<Map<String, dynamic>>;

class AvailableShelter extends StatelessWidget {
  const AvailableShelter({super.key});

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
                screenName: 'Available Shelter',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),

                // Auto location fetch on page open
                child: Obx(() {
                  final items = shelterList;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.55,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                AppSettings.baseUrl + item['cover_image'],
                                height: 90,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: const TextStyle(fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 33,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await controller
                                      .getSingleShelter(id: item['id']);
                                  Get.toNamed(
                                    '/shelter_detail',
                                    arguments: result,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  'View Detail',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
