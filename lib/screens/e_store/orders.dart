import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final EStoreController controller = Get.put(EStoreController());

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
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Track Your Order',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildFilterButton("All"),
                      buildFilterButton("Active Orders"),
                      buildFilterButton("Completed Orders"),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Obx(() {
                  var filteredList = controller.filteredCheckoutItems;

                  if (filteredList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        // horizontal: 50,
                        vertical: 80,
                      ),
                      child: Center(
                        child: Text(
                          "No orders found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, i) {
                          var item = filteredList[i];

                          String status = "Pending";

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
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
                                  child: Text(
                                    item.productName ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppFonts.primaryFontFamily,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            status.toLowerCase() == 'completed'
                                                ? const Color(0xFFD6E6FF)
                                                : const Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              status.toLowerCase() ==
                                                      "completed"
                                                  ? const Color(0xFF007BFF)
                                                  : const Color(0xFFFFB800),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Qty: ${item.quantity}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      item.unitPrice.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilterButton(String text) {
    return Obx(() {
      bool isSelected = controller.selectedOrderFilter.value == text;
      return GestureDetector(
        onTap: () => controller.changeOrderFilter(text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.backgroundColor,
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }
}
