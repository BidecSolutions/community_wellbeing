import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/models/estoremodel.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';

class TrackOrderScreen extends StatelessWidget {
  final EStoreController controller = Get.find<EStoreController>();
  final int orderId;
  TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final itemsToShow =
        controller.isBuyNow ? controller.checkoutItems : controller.cartItems;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.fetchedOrderItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyAppBar(
                    showMenuIcon: true,
                    showBackIcon: true,
                    screenName: 'Track Your Order',
                    showBottom: false,
                    userName: false,
                    showNotificationIcon: true,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Current Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // 🔹 List of fetched items
                  Column(
                    children:
                        controller.fetchedOrderItems.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: item.productImage ?? '',
                                    placeholder:
                                        (_, _) => CircularProgressIndicator(),
                                    errorWidget:
                                        (_, _, _) =>
                                            Icon(Icons.image_not_supported),
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName ?? '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "\$${item.unitPrice} x ${item.quantity}",
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE9C8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 25),
                  _orderTimeline(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _currentDeliverySection(CartStoreItem item) {
    final itemsToTrack =
        controller.isBuyNow ? controller.checkoutItems : controller.cartItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Delivery",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (itemsToTrack.isEmpty) {
            return const Text("No items found.");
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                itemsToTrack.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.productImage ?? '',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "\$${item.unitPrice?.toString().replaceAll("\$", "")} x ${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFFFE9C8),
                          ),
                          child: const Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          );
        }),
      ],
    );
  }

  Widget _orderTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Status",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _timelineTile("Order Placed", "Pending", done: true),
        _timelineConnector(),
        _timelineTile("Dispatched", "Pending", done: false),
        _timelineConnector(),
        _timelineTile("Out for Delivery", "Pending", done: false),
        _timelineConnector(),
        _timelineTile("Delivered", "Pending", done: false),
      ],
    );
  }

  Widget _timelineTile(String title, String date, {required bool done}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          alignment: Alignment.topCenter,
          child: Icon(
            done ? Icons.circle : Icons.radio_button_unchecked,
            size: 22,
            color: done ? AppColors.primaryColor : AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timelineConnector() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 30,
      width: 1.5,
      color: AppColors.primaryColor,
    );
  }

  Widget _previousOrdersPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Previous Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const Text(
            "No previous orders",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
