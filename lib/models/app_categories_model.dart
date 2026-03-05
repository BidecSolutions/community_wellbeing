class AppCategoriesModel {
  final int id;
  final String moduleName;
  final int indexing;
  final int status;
  final String icon;

  AppCategoriesModel({
    required this.id,
    required this.moduleName,
    required this.indexing,
    required this.status,
    required this.icon,
  });

  factory AppCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AppCategoriesModel(
      id: json['id'],
      moduleName: json['module_name'],
      indexing: json['indexing'],
      status: json['status'],
      icon: json['icon'],
    );
  }
}

class AllTabModel {
  final int id;
  final String formName;
  final int categoryId;
  final int status;

  AllTabModel({
    required this.id,
    required this.formName,
    required this.categoryId,
    required this.status,
  });

  factory AllTabModel.fromJson(Map<String, dynamic> json) {
    return AllTabModel(
      id: json['id'],
      formName: json['foam_name'],
      categoryId: json['category_id'],
      status: json['status'],
    );
  }
}

class PreLovedResponse {
  final DetailsModel details;
  final List<RequestModel> request;

  PreLovedResponse({required this.details, required this.request});

  factory PreLovedResponse.fromJson(Map<String, dynamic> json) {
    return PreLovedResponse(
      details: DetailsModel.fromJson(json['details']),
      request:
          (json['request'] as List)
              .map((e) => RequestModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'details': details.toJson(),
      'request': request.map((e) => e.toJson()).toList(),
    };
  }
}

class DetailsModel {
  final int id;
  final int tabId;
  final String indexName;
  final int isCategory;
  final int isSelected;
  final int isExtraSelected;
  final int isPreferenceDateTime;
  final int isPersonName;
  final int isImage;
  final int? isVerificationDocument;
  final int isType;
  final int isExtraAddress;
  final int isExtraSa2;
  final int isDescriptionBox;
  final int isSize;
  final int isItemName;
  final int isQuantity;
  final int status;

  DetailsModel({
    required this.id,
    required this.tabId,
    required this.indexName,
    required this.isCategory,
    required this.isSelected,
    required this.isExtraSelected,
    required this.isPreferenceDateTime,
    required this.isPersonName,
    required this.isImage,
    required this.isVerificationDocument,
    required this.isType,
    required this.isExtraAddress,
    required this.isExtraSa2,
    required this.isDescriptionBox,
    required this.isSize,
    required this.isItemName,
    required this.isQuantity,
    required this.status,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id'],
      tabId: json['tab_id'],
      indexName: json['index_name'],
      isCategory: json['is_category'],
      isSelected: json['is_selected'],
      isExtraSelected: json['is_extra_selected'],
      isPreferenceDateTime: json['is_preference_date_time'],
      isPersonName: json['is_person_name'],
      isImage: json['is_image'],
      isVerificationDocument: json['is_verification_document'],
      isType: json['is_type'],
      isExtraAddress: json['is_extra_address'],
      isExtraSa2: json['is_extra_sa2'],
      isDescriptionBox: json['is_description_box'],
      isSize: json['is_size'],
      isItemName: json['is_item_name'],
      isQuantity: json['is_quantity'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tab_id': tabId,
      'index_name': indexName,
      'is_category': isCategory,
      'is_selected': isSelected,
      'is_extra_selected': isExtraSelected,
      'is_preference_date_time': isPreferenceDateTime,
      'is_person_name': isPersonName,
      'is_image': isImage,
      'is_verification_document': isVerificationDocument,
      'is_type': isType,
      'is_extra_address': isExtraAddress,
      'is_extra_sa2': isExtraSa2,
      'is_description_box': isDescriptionBox,
      'is_size': isSize,
      'is_item_name': isItemName,
      'is_quantity': isQuantity,
      'status': status,
    };
  }
}

class RequestModel {
  final int id;
  final int userId;
  final int sa2Id;
  final String address;
  final String name;
  final int categoryId;
  final String image;
  final String description;
  final int quantity;
  final int conditionType;
  final int collectedType;
  final int isSold;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String statisticalAreaName;
  final String categoryName;
  final String userName;
  final String territorialName;

  RequestModel({
    required this.id,
    required this.userId,
    required this.sa2Id,
    required this.address,
    required this.name,
    required this.categoryId,
    required this.image,
    required this.description,
    required this.quantity,
    required this.conditionType,
    required this.collectedType,
    required this.isSold,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.statisticalAreaName,
    required this.categoryName,
    required this.userName,
    required this.territorialName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      userId: json['user_id'],
      sa2Id: json['sa2_id'],
      address: json['address'],
      name: json['name'],
      categoryId: json['category_id'],
      image: json['image'],
      description: json['description'],
      quantity: json['quantity'],
      conditionType: json['condition_type'],
      collectedType: json['collected_type'],
      isSold: json['is_sold'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      statisticalAreaName: json['statistical_area_name'],
      categoryName: json['category_name'],
      userName: json['user_name'],
      territorialName: json['territorial_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'sa2_id': sa2Id,
      'address': address,
      'name': name,
      'category_id': categoryId,
      'image': image,
      'description': description,
      'quantity': quantity,
      'condition_type': conditionType,
      'collected_type': collectedType,
      'is_sold': isSold,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'statistical_area_name': statisticalAreaName,
      'category_name': categoryName,
      'user_name': userName,
      'territorial_name': territorialName,
    };
  }
}
