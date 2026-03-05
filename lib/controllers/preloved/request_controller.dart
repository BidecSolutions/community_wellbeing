import 'dart:convert';
import 'dart:developer';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/preloved_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  var isLoading = false.obs;
  var selectedItems = <Product>[].obs;
  final categories = [].obs;
  var quantities = <int, RxInt>{}.obs;
  Future<void> fetchProducts(int userId, List<int> productIds) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("${AppSettings.baseUrl}pre-loved/get-cart-detail"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode({
          "status": 1,
          "userId": userId,
          "product_id": productIds,
        }),
      );

      log("📩 API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == true && data["data"] != null) {
          final List products = data["data"];

          // Group products by productId
          final Map<int, Product> groupedProducts = {};

          for (var e in products) {
            final product = Product.fromJson(e);
            final id = product.productId;

            if (groupedProducts.containsKey(id)) {
              final existing = groupedProducts[id]!;
              groupedProducts[id] = Product(
                id: existing.id, // keep original indexID for UI if needed
                productId: id,
                quantity: existing.quantity + product.quantity,
                name: product.name,
                description: product.description,
                imageUrl: product.imageUrl,
                category: product.category,
                conditionType: product.conditionType,
                collectedType: product.collectedType,
                userId: product.userId,
                userName: product.userName,
              );
            } else {
              groupedProducts[id] = product;
            }
          }

          // Update observable list
          selectedItems.assignAll(groupedProducts.values.toList());

          // Set quantities
          for (var product in selectedItems) {
            quantities[product.productId] = (product.quantity).obs;
          }
        }
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// --- quantity methods (per product) ---
  void increase(int productId) {
    if (!quantities.containsKey(productId)) {
      quantities[productId] = 1.obs;
    }
    quantities[productId]!.value++;
  }

  void decrease(int productId) {
    if (quantities.containsKey(productId) && quantities[productId]!.value > 1) {
      quantities[productId]!.value--;
    }
  }

  int getQuantity(int productId) {
    return quantities[productId]?.value ?? 1;
  }

  int get totalSelectedItems {
    return quantities.values.fold(0, (sum, qty) => sum + qty.value);
  }

  void addItem(Product product) {
    if (selectedItems.any((p) => p.productId == product.productId)) {
      increase(product.productId);
    } else {
      selectedItems.add(product);
      quantities[product.productId] = 1.obs;
    }
  }

  void removeItem(Product product) {
    final id = product.productId;
    if (quantities.containsKey(id)) {
      if (quantities[id]!.value > 1) {
        quantities[id]!.value--;
      } else {
        selectedItems.removeWhere((p) => p.productId == id);
        quantities.remove(id);
      }
    }
  }

  void clearCart() {
    selectedItems.clear();
    quantities.clear();
  }

  void addToSelected(Map<String, dynamic> productMap) {
    final imagePath = productMap['image'] ?? "";
    final fullImageUrl =
        imagePath.startsWith("http")
            ? imagePath
            : "${AppSettings.baseUrl}$imagePath";

    final product = Product(
      id: productMap['indexID'] ?? 0,
      productId: productMap['product_id'] ?? 0,
      quantity: productMap['quantity'] ?? 0,
      name: productMap['name'] ?? "",
      description: productMap['description'] ?? "",
      imageUrl: fullImageUrl,
      category: productMap['category_id'].toString(),
      conditionType: productMap['condition_type'] ?? 0,
      collectedType: productMap['collected_type'] ?? 0,
      userId: productMap['userID'] ?? 0,
      userName: productMap['userName'] ?? '',
    );

    if (!selectedItems.any((p) => p.id == product.id)) {
      selectedItems.add(product);
      quantities[product.id] = 1.obs;
    }
  }

  void removeFromSelected(Map<String, dynamic> product) {
    final productId = product['product_id'];
    selectedItems.removeWhere((p) => p.productId == productId);
    quantities.remove(productId);
  }

  void clearSelected() {
    selectedItems.clear();
    quantities.clear();
  }
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var isLoading = false.obs;
  var selectedItems = <CartItem>[].obs;
  var quantities = <int, RxInt>{}.obs;
  Future<void> fetchCartData() async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse("${AppSettings.baseUrl}pre-loved/get-cart-detail"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log("📩 API Response: ${response.body}");
        if (data["status"] == true) {
          var list = data["data"] as List;
          cartItems.value = list.map((e) => CartItem.fromJson(e)).toList();
        }
      }
    } catch (e) {
      e;
    } finally {
      isLoading(false);
    }
  }

  // Increase quantity by indexID
  void increase(int indexID) {
    final item = cartItems.firstWhereOrNull((e) => e.indexID == indexID);
    if (item != null) {
      item.quantity++;
      cartItems.refresh(); // update UI
    }
  }

  // Decrease quantity by indexID
  void decrease(int indexID) {
    final item = cartItems.firstWhereOrNull((e) => e.indexID == indexID);
    if (item != null && item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    }
  }

  // Get quantity by indexID
  int getQuantity(int indexID) {
    final item = cartItems.firstWhereOrNull((e) => e.indexID == indexID);
    return item?.quantity ?? 0;
  }

  // Delete item
  void deleteItem(int indexID) {
    cartItems.removeWhere((e) => e.indexID == indexID);
  }

  int get totalSelectedItems {
    int total = 0;

    for (var item in cartItems) {
      total += getQuantity(item.indexID);
    }

    return total;
  }

  List<Product> getExpandedProducts() {
    List<Product> expanded = [];
    for (var item in cartItems) {
      for (int i = 0; i < item.quantity; i++) {
        expanded.add(
          Product(
            id: item.indexID,
            productId: item.productId,
            quantity: 1,
            name: item.name,
            description: item.description,
            imageUrl: item.image,
            category: item.category.toString(),
            conditionType: item.conditionType,
            collectedType: item.collectedType,
            userId: item.userId,
            userName: item.userName,
          ),
        );
      }
    }
    return expanded;
  }
}
