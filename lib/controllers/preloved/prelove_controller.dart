import 'dart:convert';
import 'dart:developer';
import 'package:community_app/models/preloved_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../main.dart';

class ProductController extends GetxController {
  var selectedCategoryId = 0.obs;
  var selectedItems = <Product>[].obs;
  final categories = [].obs;
  var quantities = <int, RxInt>{}.obs;
  List indexList = [];
  RxList<Map<String, dynamic>> allCategory = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> allProducts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filter = <Map<String, dynamic>>[].obs;

  Future<void> fetchCategories() async {
    try {
      final url = Uri.parse('${AppSettings.baseUrl}pre-loved/get-all-category');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];
        if (data is List) {
          allCategory.value = [
            {"id": 0, "name": "All"},
            ...data.map<Map<String, dynamic>>((item) {
              return {"id": item['id'], "name": item['name']};
            }),
          ];
        }
      }
    } catch (e) {
      log("fetchCategories error: $e");
    }
  }

  Future<void> fetchProducts() async {
    try {
      final url = Uri.parse('${AppSettings.baseUrl}pre-loved/get-all-items');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];
        if (data is List) {
          allProducts.value =
              data.map<Map<String, dynamic>>((item) {
                return {
                  "id": item['id'],
                  "name": item['name'],
                  "category_id": item['category_id'],
                  "image": item['image'],
                  "description": item['description'],
                  "quantity": item['quantity'],
                };
              }).toList();

          filterProducts(0);
        }
      }
    } catch (e) {
      log("fetchProducts error: $e");
    }
  }

  void filterProducts(int? value) {
    selectedCategoryId.value = value ?? 0;
    if (selectedCategoryId.value == 0) {
      filter.assignAll(allProducts);
    } else {
      final filtered =
          allProducts.where((indexValue) {
            final categoryId = int.tryParse(
              indexValue['category_id'].toString(),
            );
            return categoryId == selectedCategoryId.value;
          }).toList();
      filter.assignAll(filtered);
    }
  }

  void setCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
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
    if (selectedItems.any((p) => p.id == product.id)) {
      increase(product.id);
    } else {
      selectedItems.add(product);
      quantities[product.id] = 1.obs;
    }
  }

  void removeItem(Product product) {
    if (quantities.containsKey(product.id)) {
      if (quantities[product.id]!.value > 1) {
        quantities[product.id]!.value--; // just decrease qty
      } else {
        // if only 1 left, remove the product entirely
        selectedItems.remove(product);
        quantities.remove(product.id);
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
      name: productMap['name'] ?? "",
      description: productMap['description'] ?? "",
      imageUrl: fullImageUrl,
      category: productMap['category_id'].toString(),
      id: productMap['id'] ?? 0,
      productId: productMap['product_id'] ?? 0,
      quantity: productMap['quantity'] ?? 0,
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
    selectedItems.removeWhere((p) => p.name == product['name']);
    quantities.remove(product['id']);
  }

  void clearSelected() {
    selectedItems.clear();
    quantities.clear();
  }

  List<Product> get expandedSelectedItems {
    final List<Product> expanded = [];
    indexList = [];
    for (var product in selectedItems) {
      final qty = getQuantity(product.id);
      for (int i = 0; i < qty; i++) {
        expanded.add(product);
        indexList.add(product.id);
      }
    }
    return expanded;
  }

  Future<void> addToCart(int productId, int quantity) async {
    final url = Uri.parse('${AppSettings.baseUrl}pre-loved/add-to-cart');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"product_id": productId, "quantity": quantity}),
      );
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final status = jsonResponse["status"];
        final message = jsonResponse["message"];
        if (status == true) {
          Get.snackbar(
            "Success",
            message ?? "Item added successfully",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(12),
            borderRadius: 8,
          );
        } else {
          Get.snackbar(
            "Failed",
            message ?? "Could not add item",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong (${response.statusCode})",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        "Failed to add item to cart",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
