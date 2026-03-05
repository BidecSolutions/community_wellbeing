import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/estoremodel.dart';
import 'package:community_app/models/preloved_model.dart' hide CartItem;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EStoreController extends GetxController {
  // Categories
  var isBuyNow = false;
  OrderModel? currentOrder;
  var selectedCategory = "All".obs;
  var checkoutItems = <CartStoreItem>[].obs;
  var selectedAddress = "Home".obs;
  var selectedPayment = "Cash on Delivery".obs;
  var homeAddress = "123 Market Street, Auckland 1011".obs;
  var officeAddress = "50 Downtown Road, Christchurch 8023".obs;
  var quantity = 1.obs;
  var selectedColorIndex = 0.obs;
  var checkoutTotal = 0.0.obs;
  int? orderId;
  String? type;
  var selectedOrderFilter = "All".obs;
  var orderStatuses = <int, String>{}.obs;
  final List<String> statusOptions = ["Pending", "Processing", "Completed"];
  var isLoading = false.obs;
  var estoreData = Rxn<Estore>();
  var fetchedOrderItems = <CartStoreItem>[].obs;

  RxDouble total = 0.0.obs;
  void calculateTotal() {
    total.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.unitPrice! * item.quantity!),
    );
  }

  // Color parseNameColor(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //     case "orange":
  //       return const Color(0xFFFFE0B2);
  //     case "green":
  //       return const Color(0xFFC8E6C9);
  //     case "blue":
  //       return const Color(0xFFBBDEFB);
  //     case "purple":
  //       return const Color(0xFFE1BEE7);
  //     case "red":
  //       return const Color(0xFFFFCDD2);
  //     case "white":
  //       return Colors.white;
  //     default:
  //       return Colors.grey[200]!;
  //   }
  // }

  void changeOrderFilter(String filter) {
    selectedOrderFilter.value = filter;
  }

  List<CartStoreItem> get filteredCheckoutItems {
    if (selectedOrderFilter.value == "All") {
      return checkoutItems;
    } else if (selectedOrderFilter.value == "Active Orders") {
      return checkoutItems
          .asMap()
          .entries
          .where(
            (entry) =>
                orderStatuses[entry.key] == "Pending" ||
                orderStatuses[entry.key] == "Processing",
          )
          .map((e) => e.value)
          .toList();
    } else if (selectedOrderFilter.value == "Completed Orders") {
      return checkoutItems
          .asMap()
          .entries
          .where((entry) => orderStatuses[entry.key] == "Completed")
          .map((e) => e.value)
          .toList();
    }
    return [];
  }

  void changeColor(int index) {
    selectedColorIndex.value = index;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  var cartItems = <CartStoreItem>[].obs;

  void incrementCartQuantity(int index) {
    final item = cartItems[index];
    item.quantity = (item.quantity ?? 0) + 1;
    cartItems.refresh();
  }

  void decrementCartQuantity(int index) {
    final item = cartItems[index];
    if ((item.quantity ?? 0) > 1) {
      item.quantity = (item.quantity ?? 0) - 1;
      cartItems.refresh();
    }
  }

  Future<void> getEstoreData() async {
    try {
      print('object');
      isLoading(true);
      final url = "${AppSettings.baseUrl}estore/get-estore-category";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        estoreData.value = Estore.fromJson(jsonData);
        log("Estore API response: $jsonData");
      } else {
        print('Code: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to fetch estore data');
      }
    } catch (e) {
      print('Error Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeFromCart(int index) async {
    try {
      final item = cartItems[index];

      final body = {
        "product_id": item.productId,
        "quantity": item.quantity,
        "unit_price": item.unitPrice,
      };

      print("Deleting cart item → $body");

      final response = await http.post(
        Uri.parse("${AppSettings.baseUrl}estore/delete-from-cart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode(body),
      );

      print("Delete Response Code: ${response.statusCode}");
      print("Delete Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        cartItems.removeAt(index);
        cartItems.refresh();
        calculateTotal();

        Get.snackbar(
          "Removed",
          "Item removed from cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.black,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to remove item",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
      }
    } catch (e) {
      print("Delete error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
    }
  }

  Future<void> addToCart(ProductModel product, int quantity) async {
    const String apiUrl = "${AppSettings.baseUrl}estore/add-to-cart";

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode({
          "product_id": product.id,
          "quantity": quantity,
          "unit_price": product.price ?? 0,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.snackbar(
          "Success",
          data["message"] ?? "Added to cart successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchCart();
      } else {
        Get.snackbar(
          "Error",
          "Failed to add to cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFFE5E5),
          colorText: const Color(0xFFB00020),
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> fetchCart() async {
    const String apiUrl = "${AppSettings.baseUrl}estore/fetch-cart";
    print("🔄 fetchCart() called");

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
      );

      isLoading.value = false;

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["status"] == true && data["data"] != null) {
          final List cartData = data["data"];
          cartItems.clear();
          print('cart data: $data');
          for (var item in cartData) {
            cartItems.add(CartStoreItem.fromJson(item));
          }
          log(" fetchCartCode: ${response.statusCode}");
          log("fetchCart: $data");
          calculateTotal();
          print("🔄 fetchCart() called again");
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch cart items",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFFE5E5),
          colorText: const Color(0xFFB00020),
        );
      }
    } catch (e) {
      isLoading.value = false;
      print("Error fetching cart: $e");
    }
  }

  Future<int?> createOrder() async {
    try {
      final body = {
        "data":
            cartItems
                .map(
                  (item) => {
                    "cart_id": item.cartId,
                    "qty": item.quantity,
                    "unit_price": item.unitPrice,
                  },
                )
                .toList(),
      };

      print("Sending createOrder request: $body");

      final response = await http.post(
        Uri.parse("${AppSettings.baseUrl}estore/create-order"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode(body),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['status'] == true) {
        print("Order Created Successfully");
        return 1;
      } else {
        print("Order Creation Failed");
        return null;
      }
    } catch (e) {
      print("createOrder Exception: $e");
      return null;
    }
  }

  Future<bool> checkout(int orderId) async {
    if (cartItems.isEmpty) return false;

    try {
      isLoading.value = true;

      for (var item in cartItems) {
        final body = {
          "order_id": orderId,
          "product_id": item.productId,
          "quantity": item.quantity ?? 1,
          "unit_price": item.unitPrice ?? 0.0,
          "total_amount": (item.unitPrice ?? 0.0) * (item.quantity ?? 1),
        };
        print("Checkout called with orderId: $orderId");
        print("Sending checkout request: $body");

        final response = await http.post(
          Uri.parse("${AppSettings.baseUrl}estore/checkout"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${box.read('token')}",
          },
          body: jsonEncode(body),
        );

        print("Response Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        final data = jsonDecode(response.body);

        if (response.statusCode != 200 && response.statusCode != 201) {
          Get.snackbar(
            "Error",
            "Failed with status ${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[100],
            colorText: Colors.black,
          );
          return false;
        }

        //   if (data["status"] != true) {
        //     Get.snackbar(
        //       "Error",
        //       data["message"] ?? "Checkout failed",
        //       snackPosition: SnackPosition.BOTTOM,
        //       backgroundColor: Colors.red[100],
        //       colorText: Colors.black,
        //     );
        //     return false;
        //   }
      }

      Get.snackbar(
        "Success",
        "Checkout completed successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.black,
      );

      return true;
    } catch (e) {
      print("Checkout Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong during checkout",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrder({required int orderId, String? type}) async {
    final body = {"order_id": orderId, "type": type};
    print("Fetching order with body: $body");

    final response = await http.post(
      Uri.parse("${AppSettings.baseUrl}estore/fetch-order"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${box.read('token')}",
      },
      body: jsonEncode(body),
    );

    print("Fetch Response Code: ${response.statusCode}");
    print("Fetch Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data["status"] == true &&
          data["orders"] != null &&
          data["orders"].isNotEmpty &&
          data["orders"][0]["details"] != null) {
        fetchedOrderItems.assignAll(
          (data["orders"][0]["details"] as List)
              .map((item) => CartStoreItem.fromJson(item))
              .toList(),
        );
        print("Fetched order items: ${fetchedOrderItems.value}");
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Failed to fetch order",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Failed with status ${response.statusCode}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
    }
  }

  var selectedVariant = Rxn<VariantModel>();

  void selectVariant(int index, ProductModel product) {
    if (product.variants != null && product.variants!.isNotEmpty) {
      selectedVariant.value = product.variants![index];
    }
  }

  void updateFilteredProducts(String categoryName) {
    final category = estoreData.value?.categoriesWithProducts?.firstWhereOrNull(
      (e) => e.name == categoryName,
    );

    filteredProducts.value = category?.products ?? [];
  }

  // void removeFromCart(int index) {
  //   cartItems.removeAt(index);
  // }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      final price = item.unitPrice ?? 0.0;
      final qty = item.quantity ?? 0;
      return sum + (price * qty);
    });
  }

  // Products
  var products =
      <EStoreModel>[
        EStoreModel(
          title: "Gigabyte Aorus Master 15 Review Powerful Graphics, LED RGB",
          price: "\$345.00",
          image:
              "https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/257726_Gigabyte_Aorus_Master_16_laptop_ADiBenedetto_0024.jpg?quality=90&strip=all&crop=0%2C0%2C100%2C100&w=1200",
          stock: 200,
          description:
              "The Gigabyte Aorus Master 15 features a powerful GPU, customizable RGB lighting, and high refresh-rate display ideal for gaming and graphic-intensive tasks.",
        ),
        EStoreModel(
          stock: 10,
          title: "Smartphone Samsung Galaxy S23 Ultra 5G",
          price: "\$999.00",
          image:
              "https://m-cdn.phonearena.com/images/article/144208-wide-two_940/Galaxy-S23-Ultra-specs-revealed-by-Chinese-regulatory-agency-and-the-FCC.webp?1670862011",
          description:
              "Samsung Galaxy S23 Ultra offers a 200MP camera, 5G connectivity, AMOLED display, and long-lasting battery performance with S-Pen support.",
        ),
        EStoreModel(
          stock: 60,
          title: "Headphone Sony WH-1000XM4 Noise Cancelling",
          price: "\$299.00",
          image:
              "https://techcrunch.com/wp-content/uploads/2020/08/20200819_162104.jpg?resize=1200,900",
          description:
              "Sony WH-1000XM4 delivers industry-leading noise cancellation, rich bass, 30-hour battery life, and support for multipoint Bluetooth connectivity.",
        ),
        EStoreModel(
          stock: 30,
          title: "Laptop MacBook Pro M2 Max 2023",
          price: "\$1999.00",
          image:
              "https://propakistani.pk/wp-content/uploads/2023/01/Apple-MacBook-Pro-M2-scaled-e1674024208483.jpg",
          description:
              "The MacBook Pro M2 Max (2023) features a Liquid Retina XDR display, 12-core CPU, 38-core GPU, and exceptional performance for creators and developers.",
        ),
        EStoreModel(
          stock: 5,
          title: "Laptop MacBook M4 Max 2023",
          price: "\$345.00",
          image:
              "https://i.guim.co.uk/img/media/4859367e7677e9c8920da1639a989d254716afde/352_398_4688_2812/master/4688.jpg?width=1900&dpr=1&s=none&crop=none",
          description:
              "A high-performance gaming laptop with advanced cooling, RGB keyboard, and dedicated graphics for smooth FPS and multitasking.",
        ),
        EStoreModel(
          stock: 17,
          title: "iphone 17",
          price: "\$999.00",
          image:
              "https://qmart.pk/wp-content/uploads/2025/09/Apple-iPhone-17-Pro-Max-Qmart-4.png",
          description:
              "Experience 5G speed, a stunning 120Hz display, and professional-grade quad-camera setup with enhanced night photography features.",
        ),
        EStoreModel(
          stock: 27,
          title: "Headphone Sony WH-1000XM4",
          price: "\$299.00",
          image:
              "https://www.cnet.com/a/img/resize/e9782c53e722c7f3ae2d9976680be3c046717559/hub/2020/08/06/700ec86a-e8da-423e-af47-f44281027a5a/sony-wh-1000xm4-1.jpg?auto=webp&fit=crop&height=362&width=644",
          description:
              "Enjoy immersive sound quality, adaptive noise control, and comfortable cushioning built for daily use and travel.",
        ),
        EStoreModel(
          stock: 23,
          title: "Samsung Galaxy Book 750",
          price: "\$1999.00",
          image:
              "https://hf-store.pk/wp-content/uploads/2025/02/WhatsApp-Image-2025-02-18-at-17.10.46_a3edd5cd.jpg",
          description:
              "Built for productivity and performance with long battery life, upgraded speakers, and seamless macOS integration.",
        ),
      ].obs;

  var filteredProducts = <ProductModel>[].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkoutItems.clear();
    checkoutItems.addAll(cartItems);
    getEstoreData();
    fetchCart();
    // Only fetch if both orderId and type are provided
    if (orderId != null && type != null) {
      fetchOrder(orderId: orderId!, type: type!);
    }
    update();
  }
}
