import 'package:community_app/app_settings/settings.dart';

class Product {
  final int id;
  final int productId;
  final int quantity;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final int conditionType;
  final int collectedType;
  final int userId;
  final String userName;

  Product({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.conditionType,
    required this.collectedType,
    required this.userId,
    required this.userName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final imagePath = json['image'] ?? '';
    return Product(
      id: json['indexID'],
      productId: json['product_id'],
      quantity: json['quantity'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl:
          imagePath.startsWith("http")
              ? imagePath
              : "${AppSettings.baseUrl}$imagePath",
      category: json['category_id']?.toString() ?? '',
      conditionType: json['condition_type'],
      collectedType: json['collected_type'],
      userId: json['userID'],
      userName: json['userName'],
    );
  }
}

class CartItem {
  final int indexID;
  final int productId;
  int quantity;
  final String name;
  final int categoryId;
  final String description;
  final String image;
  final int conditionType;
  final int collectedType;
  final int userId;
  final String userName;
  final dynamic category;

  CartItem(
    this.category, {
    required this.indexID,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.image,
    required this.conditionType,
    required this.collectedType,
    required this.userId,
    required this.userName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      json['category'] ?? json['category_id'] ?? json['categoryId'] ?? '',
      indexID: json['indexID'],
      productId: json['product_id'],
      quantity: json['quantity'],
      name: json['name'],
      categoryId: json['category_id'],
      description: json['description'],
      image:
          json['image'] != null && json['image'].toString().isNotEmpty
              ? "${AppSettings.baseUrl}${json['image']}"
              : '',
      conditionType: json['condition_type'],
      collectedType: json['collected_type'],
      userId: json['userID'],
      userName: json['userName'],
    );
  }
}
