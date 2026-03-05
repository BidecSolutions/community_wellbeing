import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';
import 'package:community_app/models/estoremodel.dart';
import 'package:community_app/screens/e_store/trackingorderscreen.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  final int orderId;
  final String type;
  CheckoutScreen({required this.orderId, required this.type, Key? key})
    : super(key: key);

  final EStoreController controller = Get.find<EStoreController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.fetchedOrderItems.isEmpty) {
        controller.fetchOrder(orderId: orderId, type: type);
      }
    });

    double total = controller.fetchedOrderItems.fold(0.0, (sum, item) {
      double price = (item.unitPrice ?? 0.0);
      int quantity = item.quantity ?? 1;
      return sum + price * quantity;
    });

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
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Checkout',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 30),
                const Text(
                  "Shipping Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _addressTile("Home", "123 Market Street, Auckland 1011"),
                _addressTile("Office", "50 Downtown Road, Christchurch 8023"),

                const SizedBox(height: 20),
                const Text(
                  "Order Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Obx(
                  () => Column(
                    children:
                        controller.fetchedOrderItems.isEmpty
                            ? [Text("No items in order")]
                            : controller.fetchedOrderItems
                                .map((item) => _orderItemTile(item))
                                .toList(),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Items: (${controller.fetchedOrderItems.length})"),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Obx(
                  () => Row(
                    children: [_paymentOption("Cash on Delivery", Icons.money)],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 125,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () async {
                      print("Confirm pressed → Using orderId: ${orderId}");

                      if (controller.fetchedOrderItems.isEmpty) {
                        Get.snackbar(
                          "No Items",
                          "There are no items to checkout.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red[100],
                          colorText: Colors.black,
                        );
                        return;
                      }

                      final success = await controller.checkout(orderId);
                      _showConfirmDialog(orderId);
                      if (success) {
                        _onConfirm(total);
                        _showConfirmDialog(orderId);
                        controller.isBuyNow = false;
                        controller.calculateTotal();
                      }
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _addressTile(String label, String address) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedAddress.value = label;
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Radio<String>(
                value: label,
                groupValue: controller.selectedAddress.value,
                onChanged: (val) {
                  controller.selectedAddress.value = val!;
                },
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(address, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),

              IconButton(
                icon: Icon(Icons.edit, color: Colors.grey[600]),
                onPressed: () {
                  _showEditAddressDialog(label, address);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditAddressDialog(String label, String oldAddress) {
    final TextEditingController addressController = TextEditingController(
      text: oldAddress,
    );

    Get.defaultDialog(
      titlePadding: EdgeInsets.all(16),
      backgroundColor: AppColors.backgroundColor,
      title: "Edit $label Address",
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      content: Column(
        children: [
          TextField(
            controller: addressController,
            decoration: const InputDecoration(labelText: "Enter new address"),
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      buttonColor: AppColors.primaryColor,
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (label == "Home") {
          controller.homeAddress.value = addressController.text;
        } else if (label == "Office") {
          controller.officeAddress.value = addressController.text;
        }
        Get.back();
      },
    );
  }

  void _showConfirmDialog(int orderId) {
    Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
      title: "Thank You!",
      titleStyle: TextStyle(fontWeight: FontWeight.w800),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Order Number: #$orderId",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 15),
          const Text(
            "Estimated Delivery Time: 3 to 5 working days",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          Get.to(() => TrackOrderScreen(orderId: orderId));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        ),
        child: const Text(
          "Track Your Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _orderItemTile(CartStoreItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.productImage ?? '',
              placeholder: (_, _) => CircularProgressIndicator(),
              errorWidget: (_, _, _) => Icon(Icons.image_not_supported),
              height: 70,
              width: 70,
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
        ],
      ),
    );
  }

  Widget _paymentOption(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        controller.selectedPayment.value = label;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(
            color:
                controller.selectedPayment.value == label
                    ? AppColors.primaryColor
                    : AppColors.backgroundColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color:
                  controller.selectedPayment.value == label
                      ? AppColors.primaryColor
                      : Colors.grey,
            ),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _onConfirm(double total) {
    Get.snackbar(
      "Order Confirmed",
      "Total: \$${total.toStringAsFixed(2)}\nPayment Method is ${controller.selectedPayment.value}",
      snackPosition: SnackPosition.TOP,
    );
  }

  Widget _cardInputs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    hintText: "Cardholder Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller.numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Card Number",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller.expiryController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    hintText: "Expiry",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller.cvvController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "CVV",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
