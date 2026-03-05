import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = ''.obs;

  void pickDate() async {
    DateTime? picked = await Get.dialog(
      DatePickerDialog(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      ),
    );

    if (picked != null) {
      selectedDate.value = "${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
}
