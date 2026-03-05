import 'dart:ui';

class EStoreModel {
  final String title;
  final String price;
  final String image;
  final int stock;
  final String description;

  EStoreModel({
    required this.stock,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });
}

class CartStoreItem {
  final int? cartId;
  final int? productId;
  final int? variantId;
  int? quantity;
  final double? unitPrice;
  final String? productName;
  final String? productImage;
  final String? variantImage;
  final String? variantName;

  CartStoreItem({
    this.cartId,
    this.productId,
    this.variantId,
    this.quantity,
    this.unitPrice,
    this.productName,
    this.productImage,
    this.variantImage,
    this.variantName,
  });

  factory CartStoreItem.fromJson(Map<String, dynamic> json) {
    return CartStoreItem(
      cartId: _toInt(json['cart_id']),
      productId: _toInt(json['product_id']),
      variantId: _toInt(json['varient_id']),
      quantity: _toInt(json['quantity']) ?? 1,
      unitPrice: _toDouble(json['unit_price']),
      productName: json['product_name']?.toString(),
      productImage: json['product_image']?.toString(),
      variantImage: json['varient_image']?.toString(),
      variantName: json['epv_varient_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'cart_id': cartId,
    'product_id': productId,
    'varient_id': variantId,
    'quantity': quantity,
    'unit_price': unitPrice,
    'product_name': productName,
    'product_image': productImage,
    'varient_image': variantImage,
    'epv_varient_name': variantName,
  };

  static int? _toInt(dynamic v) =>
      v == null ? null : int.tryParse(v.toString());

  static double? _toDouble(dynamic v) =>
      v == null ? null : double.tryParse(v.toString());
}

class Estore {
  final List<BannerModel>? banners;
  final List<CategoryWithProducts>? categoriesWithProducts;

  Estore({this.banners, this.categoriesWithProducts});

  factory Estore.fromJson(Map<String, dynamic> json) {
    return Estore(
      banners:
          (json['banner'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList(),
      categoriesWithProducts:
          (json['categoriesWithProducts'] as List?)
              ?.map((e) => CategoryWithProducts.fromJson(e))
              .toList(),
    );
  }
}

class BannerModel {
  final int? id;
  final String? bannerImage;
  final String? pageName;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  BannerModel({
    this.id,
    this.bannerImage,
    this.pageName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      bannerImage: json['banner_image'],
      pageName: json['page_name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'banner_image': bannerImage,
      'page_name': pageName,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class VariantModel {
  final int? id;
  final String? name;
  final double? price;
  final String? image;
  final int? productId;
  final String? attributeType;
  final String? attributeValue;
  final String? description;
  final int? stock;
  final String? createdAt;
  final String? updatedAt;

  VariantModel({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.image,
    this.attributeType,
    this.attributeValue,
    this.description,
    this.stock,
    this.createdAt,
    this.updatedAt,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'],
      name: json['varient_name'],
      attributeType: json['attribute_type'],
      attributeValue: json['attribute_value'],
      image: json['image'],
      productId: json['product_id'],
      price:
          (json['unit_price'] != null)
              ? double.tryParse(json['unit_price'].toString())
              : null,
      description: json['description'],
      stock: json['stock'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ProductModel {
  final int? id;
  final String? name;
  final String? image;
  final double? price;
  final String? description;
  final String? productType;
  final int? categoryId;
  final int? hasVariants;
  final int? stock;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final List<VariantModel>? variants;

  ProductModel({
    this.categoryId,
    this.hasVariants,
    this.productType,
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.stock,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['product_name'],
      image: json['image'],
      price:
          (json['unit_price'] != null)
              ? double.tryParse(json['unit_price'].toString())
              : null,
      description: json['description'],
      productType: json['product_type'],
      categoryId: json['category_id'],
      hasVariants: json['hasVariants'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      variants:
          (json['variants'] as List?)
              ?.map((e) => VariantModel.fromJson(e))
              .toList(),
      stock: json['stock'],
    );
  }
}

class CategoryWithProducts {
  final int? id;
  final String? name;
  final String? image;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final List<ProductModel>? products;

  CategoryWithProducts({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory CategoryWithProducts.fromJson(Map<String, dynamic> json) {
    return CategoryWithProducts(
      id: json['id'],
      name: json['cate_name'],
      image: json['icon'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      products:
          (json['products'] as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList(),
    );
  }
}

class OrderModel {
  final int? id;
  final String? orderNumber;
  final double? orderAmount;
  final int? userId;
  final int? paymentStatus;
  final String? trackingStatus;
  final String? createdAt;
  final String? updatedAt;

  OrderModel({
    this.id,
    this.orderNumber,
    this.orderAmount,
    this.userId,
    this.paymentStatus,
    this.trackingStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      orderAmount:
          (json['order_amount'] is num)
              ? (json['order_amount'] as num).toDouble()
              : double.tryParse(json['order_amount'].toString()),
      userId: json['user_id'],
      paymentStatus: json['payemnt_status'],
      trackingStatus: json['tracking_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
