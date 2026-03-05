import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';
import 'package:community_app/screens/e_store/checkoutscreen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.put(EStoreController());

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ─────────── App-bar ─────────── */ MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Cart',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 30),
                Text(
                  'Your Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentColor,
                  ),
                ),
                Obx(
                  () =>
                      controller.cartItems.isEmpty
                          ? Center(child: Text("No items in cart"))
                          : Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.cartItems.length,
                                itemBuilder: (context, index) {
                                  final item = controller.cartItems[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteTextField,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.top,
                                          contentPadding: EdgeInsets.zero,
                                          leading: Image.network(
                                            item.productImage ?? '',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            item.productName ?? '',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            "\$${item.unitPrice ?? 0}",
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed:
                                                    () => controller
                                                        .decrementCartQuantity(
                                                          index,
                                                        ),
                                              ),
                                              Text("${item.quantity ?? 1}"),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed:
                                                    () => controller
                                                        .incrementCartQuantity(
                                                          index,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                          onPressed:
                                              () => controller.removeFromCart(
                                                index,
                                              ), // implement this in controller
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  return SizedBox(height: 5);
                                },
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "Selected Items (${controller.cartItems.length})",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        "Total: \$${controller.totalPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 32,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: () async {
                                  // Create the order
                                  final orderId =
                                      await controller.createOrder();
                                  if (orderId == null) {
                                    Get.snackbar(
                                      "Error",
                                      "Failed to create order. Please try again.",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red[100],
                                      colorText: Colors.black,
                                    );
                                    return;
                                  }

                                  // Move items from cart to checkout
                                  controller.checkoutItems
                                    ..clear()
                                    ..addAll(controller.cartItems);
                                  controller.isBuyNow = false;
                                  controller.calculateTotal();

                                  // Navigate to checkout
                                  Get.to(
                                    () => CheckoutScreen(
                                      orderId: orderId,
                                      type: "pending",
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Proceed to Payment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
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
