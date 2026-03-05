import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/models/preloved_model.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EssentialForm extends GetxController {
  var selectedItems = <Product>[].obs;
  var quantities = <int, RxInt>{}.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  final nameError = ''.obs;
  final phoneError = ''.obs;
  var addressError = ''.obs;
  var descriptionError = ''.obs;
  var requestName = ''.obs;
  var requestId = 0.obs;
  List productList = [];
  var selectedTA = ''.obs;
  var selectedSA2 = ''.obs;
  var selectedOWNED = ''.obs;
  var selectedRequest = RxnInt();
  final message = "".obs;
  var contactedType = RxnInt();

  void selectInspectionType(int type) {
    contactedType.value = type;
  }

  Future<bool> sendRequest() async {
    if (addressController.text.isEmpty) {
      message.value = "Please Enter Your Address";
      return false;
    }
    if (selectedSA2.isEmpty) {
      message.value = "Please Select your Statistical Area 2";
      return false;
    }

    final url = Uri.parse('${AppSettings.baseUrl}pre-loved/essential-request');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "cart_detail_id": productList,
        "sa2": selectedSA2.value,
        "address": addressController.text,
        "description": descriptionController.text
      }),
    );
    if(response.statusCode == 201){
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      message.value = jsonResponse['message'].toString();
      addressController.text = "";
      descriptionController.text = "";
      selectedSA2.value = "";
      return true;
    }
    else{
      message.value = "Request not Send";
      return false;
    }
  }

  List<Product> get expandedSelectedItems {
    final List<Product> expanded = [];
    for (var product in selectedItems) {
      final qty = getQuantity(product.id);
      for (int i = 0; i < qty; i++) {
        expanded.add(product);
      }
    }
    return expanded;
  }

  int getQuantity(int productId) {
    return quantities[productId]?.value ?? 1;
  }
}
