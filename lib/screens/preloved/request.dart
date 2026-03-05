import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/preloved/prelove_controller.dart';
import 'package:community_app/controllers/preloved/request_controller.dart';
import 'package:community_app/screens/preloved/EssentialsRequestFormScreen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestScreen extends StatefulWidget {
  // final List<CartItem> cart;
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.fetchCartData(); // fetch data when screen initializes
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Request List',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                const SizedBox(height: 60),
                Text(
                  "Your Selected Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (cartController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (cartController.cartItems.isEmpty) {
                    return Center(child: Text("No items in cart"));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return Stack(
                        children: [
                          ListTile(
                            titleAlignment: ListTileTitleAlignment.top,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            tileColor: AppColors.backgroundColor,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                item.image.startsWith("http")
                                    ? item.image
                                    : "${AppSettings.baseUrl}${item.image}", // Full path
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item.name,
                              style: TextStyle(
                                fontFamily: AppFonts.secondaryFontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              item.description,
                              style: TextStyle(
                                fontFamily: AppFonts.primaryFontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartController.decrease(item.indexID);
                                  },
                                  icon: const Icon(Icons.remove, size: 10),
                                ),
                                Obx(
                                  () => Text(
                                    cartController
                                        .getQuantity(item.indexID)
                                        .toString()
                                        .padLeft(2, '0'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartController.increase(item.indexID);
                                  },
                                  icon: const Icon(Icons.add, size: 10),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -8,
                            top: -8,
                            child: IconButton(
                              onPressed: () {
                                cartController.deleteItem(item.indexID);
                              },
                              icon: const Icon(Icons.close, size: 16),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                  );
                }),
                SizedBox(height: 20),
                //                 // Selected items count
                Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(() {
                    return Text(
                      "Selected Items: [${cartController.totalSelectedItems}]",
                      style: const TextStyle(fontSize: 14),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final productController = Get.put(ProductController());

                      final expandedList = cartController.getExpandedProducts();
                      productController.selectedItems.assignAll(expandedList);

                      Get.toNamed('/essentials_request');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
