import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';
import 'package:community_app/models/estoremodel.dart';
import 'package:community_app/screens/e_store/product_detail.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EStore extends StatelessWidget {
  EStore({super.key});

  final controller = Get.put(EStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(70),
      //   child: AppBar(
      //     backgroundColor: AppColors.screenBg,
      //     elevation: 0,
      //     automaticallyImplyLeading: false, // removes default drawer icon
      //     flexibleSpace: SafeArea(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //         child: Row(
      //           children: [
      //             // ─────── Back Button ───────
      //             IconButton(
      //               icon: Icon(
      //                 Icons.arrow_back_ios_new,
      //                 color: AppColors.primaryColor,
      //               ),
      //               onPressed: () {
      //                 Get.back();
      //               },
      //             ),

      //             // ─────── Search Bar ───────
      //             Expanded(
      //               child: Container(
      //                 height: 40,
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //                 child: TextField(
      //                   onChanged: (value) {
      //                     // controller.searchProducts(value);
      //                   },
      //                   decoration: InputDecoration(
      //                     hintText: 'Search products...',
      //                     hintStyle: TextStyle(
      //                       fontSize: 14,
      //                       color: Colors.grey,
      //                     ),
      //                     border: InputBorder.none,
      //                     contentPadding: EdgeInsets.only(
      //                       top: 3,
      //                       left: 15,
      //                       bottom: 10,
      //                       right: 10,
      //                     ),
      //                     prefixIcon: Icon(
      //                       Icons.search,
      //                       color: AppColors.primaryColor,
      //                     ),
      //                     suffixIcon: GestureDetector(
      //                       child: Container(
      //                         padding: EdgeInsets.only(
      //                           top: 10,
      //                           left: 8,
      //                           right: 8,
      //                         ),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(8),
      //                           color: AppColors.primaryColor,
      //                         ),
      //                         child: Text(
      //                           'Search',
      //                           style: TextStyle(
      //                             color: AppColors.backgroundColor,
      //                             fontWeight: FontWeight.w600,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: '',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              SizedBox(height: 20),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: EcommerceCarousel(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ─────────── App-bar ─────────── */
                    // MyAppBar(
                    //   showMenuIcon: true,
                    //   showBackIcon: true,
                    //   screenName: 'E-Store',
                    //   showBottom: false,
                    //   userName: false,
                    //   showNotificationIcon: true,
                    // ),
                    // SizedBox(height: 30),

                    // Banner
                    const SizedBox(height: 20),

                    // Categories
                    // Text(
                    //   "Categories",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    Obx(() {
                      final estore = controller.estoreData.value;

                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (estore == null ||
                          estore.categoriesWithProducts == null) {
                        return const Center(
                          child: Text(
                            "Loading.....",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      if (estore.categoriesWithProducts!.isEmpty) {
                        return const Center(
                          child: Text("No categories available"),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              estore.categoriesWithProducts!.map((category) {
                                final catName = category.name ?? "Unnamed";
                                final isSelected =
                                    controller.selectedCategory.value ==
                                    catName;

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedCategory.value = catName;
                                    controller.updateFilteredProducts(catName);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? Colors.deepPurple
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? Colors.deepPurple
                                                : Colors.black,
                                      ),
                                    ),
                                    child: Text(
                                      catName,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    Obx(() {
                      final products = controller.filteredProducts;

                      if (products.isEmpty) {
                        final allProducts =
                            controller.estoreData.value?.categoriesWithProducts
                                ?.expand<ProductModel>((cat) {
                                  final list = cat.products;
                                  if (list is List<ProductModel>) {
                                    return list;
                                  } else {
                                    return (list as dynamic)
                                        .map((e) => ProductModel.fromJson(e))
                                        .toList();
                                  }
                                })
                                .toList() ??
                            [];

                        return _buildProductGrid(controller, allProducts);
                      }

                      // otherwise show filtered products
                      return _buildProductGrid(controller, products);
                    }),
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

Widget _buildProductGrid(
  EStoreController controller,
  List<ProductModel> products,
) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.68,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () => Get.to(() => ProductDetailScreen(product: product)),
              child: Stack(
                children: [
                  Image.network(
                    product.image ?? '',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 140,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.backgroundColor,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.card_travel,
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          controller.addToCart(
                            product,
                            controller.quantity.value,
                          );
                          Get.snackbar(
                            'Cart',
                            'Added to cart.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  product.price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class EcommerceCarousel extends StatelessWidget {
  final controller = Get.put(EStoreController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(height: 100, width: 100, color: AppColors.greyColor),
        );
      }

      final banners = controller.estoreData.value?.banners ?? [];
      if (banners.isEmpty) return SizedBox();

      return CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          final banner = banners[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: banner.bannerImage ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 0.9,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }
}
