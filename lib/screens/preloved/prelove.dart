import 'dart:developer';

import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/preloved/prelove_controller.dart';
import 'package:community_app/screens/preloved/donate_appliances.dart';
import 'package:community_app/screens/preloved/request.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_settings/settings.dart';

class PreLoved extends StatefulWidget {
  const PreLoved({super.key});

  @override
  State<PreLoved> createState() => _PreLovedState();
}

class _PreLovedState extends State<PreLoved> {
  final ProductController controller = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    controller.fetchCategories();
    controller.fetchProducts();
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Pre Love',
                  showBottom: true,
                  userName: false,
                  showNotificationIcon: false,
                ),
                const SizedBox(height: 60),
                Center(
                  child: Text(
                    "Donate Appliances",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Share what you can — your donation could meet someone’s basic need.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontFamily: AppFonts.primaryFontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Card Section
                GestureDetector(
                  onTap: () {
                    Get.to(() => DonateAppliances());
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(
                      "assets/images/preloved/image (8).png",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),

                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          controller.allCategory.map((category) {
                            final id = category["id"] as int;
                            final name = category["name"] as String;
                            bool isSelected =
                                controller.selectedCategoryId == id;
                            return GestureDetector(
                              onTap: () => controller.filterProducts(id),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.filter.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No data found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.5,
                        ),
                    itemCount: controller.filter.length,
                    itemBuilder: (context, index) {
                      final product = controller.filter[index];
                      return ProductDetails(product: product);
                    },
                  );
                }),

                Obx(() {
                  final selectedCount = controller.selectedItems.length;
                  if (selectedCount == 0) {
                    return SizedBox.shrink();
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(${selectedCount.toString().padLeft(2, '0')}) Items Selected",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/request');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "View Request List",
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontSize: 12,
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final Map<String, dynamic> product;
  ProductDetails({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final imagePath = AppSettings.baseUrl;
    if (product.isEmpty) {
      return const Center(child: Text("No Product Found"));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              "$imagePath${product['image'] ?? ''}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
            ),
          ),
          const SizedBox(height: 5),

          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['name']?.toString() ?? "Unnamed",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),
              Text(
                product['description']?.toString() ?? "No description",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Quantity: ${product['quantity']?.toString() ?? '0'}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),

              // Button
              ElevatedButton(
                onPressed: () {
                  controller.addToSelected(product);

                  final productId = product['id'];
                  final quantity = controller.getQuantity(productId)!;

                  log(
                    "[🛒] Requesting product $productId with quantity $quantity",
                  );

                  controller.addToCart(productId, quantity);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Request Now",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
