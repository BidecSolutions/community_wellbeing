import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SomeoneKnowController extends GetxController {
  var selectedOption = ''.obs;
  var toggleValue = false.obs;


  void selectOption(String option) {
    selectedOption.value = option;
  }

  final List<String> relations = ["Mom", "Dad", "Brother"];
  var selectedRelation = "Mom".obs;

  final descriptionController = TextEditingController();
  var descriptionError = ''.obs;

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }

}
