import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';
import 'package:community_app/models/estoremodel.dart';
import 'package:community_app/models/preloved_model.dart';
import 'package:community_app/screens/e_store/cartscreen.dart';
import 'package:community_app/screens/e_store/checkoutscreen.dart';
import 'package:community_app/screens/e_store/e_store.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/screens/widgets/app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  ProductDetailScreen({super.key, required this.product});

  final EStoreController controller = Get.find<EStoreController>();

  @override
  Widget build(BuildContext context) {
    final variant = controller.selectedVariant.value;
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: '',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    variant?.image ?? product.image ?? '',
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "\$${variant?.price?.toStringAsFixed(2) ?? product.price?.toStringAsFixed(2) ?? '0.00'}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      variant?.name ?? product.name ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${variant?.stock ?? product.stock ?? 0} Stock Left",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFF66B61),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      variant?.description ?? product.description ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

              // Obx(() {
              //   return               }),
              const SizedBox(height: 15),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Colors",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.primaryFontFamily,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(
                            (product.variants ?? []).length,
                            (index) {
                              final variants = product.variants ?? [];
                              final colorName =
                                  (variant?.attributeValue ?? "grey")
                                      .toLowerCase();
                              Color getColorFromName(String name) {
                                switch (name) {
                                  case "red":
                                    return Colors.red;
                                  case "black":
                                    return Colors.black;
                                  case "blue":
                                    return Colors.blue;
                                  case "green":
                                    return Colors.green;
                                  case "white":
                                    return Colors.white;
                                  case "yellow":
                                    return Colors.yellow;
                                  case "grey":
                                  case "gray":
                                    return Colors.grey;
                                  case "purple":
                                    return Colors.purple;
                                  case "orange":
                                    return Colors.orange;
                                  case "pink":
                                    return Colors.pink;
                                  default:
                                    return Colors.grey;
                                }
                              }

                              final color = getColorFromName(colorName);
                              final isSelected =
                                  controller.selectedVariant.value ==
                                  variants[index];

                              return GestureDetector(
                                onTap:
                                    () => controller.selectVariant(
                                      index,
                                      product,
                                    ),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                    border: Border.all(
                                      width: isSelected ? 3 : 1,
                                      color:
                                          isSelected
                                              ? Colors.deepPurple
                                              : Colors.black26,
                                    ),
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.primaryFontFamily,
                          ),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              IconButton(
                                onPressed: controller.decrementQuantity,
                                icon: Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              Text(
                                "${controller.quantity.value}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                onPressed: controller.incrementQuantity,
                                icon: const Icon(
                                  Icons.add,
                                  size: 15,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // const Icon(Icons.star, color: Colors.amber, size: 22),
                    // const Icon(Icons.star, color: Colors.amber, size: 22),
                    // const Icon(Icons.star, color: Colors.amber, size: 22),
                    const Icon(Icons.star_half, color: Colors.amber, size: 22),
                    // const Icon(
                    //   Icons.star_border,
                    //   color: Colors.amber,
                    //   size: 22,
                    // ),
                    const SizedBox(width: 8),
                    Text(
                      "(4.5)",
                      style: TextStyle(fontFamily: AppFonts.primaryFontFamily),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.security_outlined,
                      size: 20,
                      color: const Color.fromARGB(255, 91, 89, 89),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '14 days easy return',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.delivery_dining_sharp,
                      size: 20,
                      color: const Color.fromARGB(255, 91, 89, 89),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '4-5 working days.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),

                          onPressed: () {
                            controller.addToCart(
                              product,
                              controller.quantity.value,
                            );
                            Get.to(() => CartScreen());
                          },

                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () async {
                            final orderId = await controller.createOrder();
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
                            "Buy Now",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
