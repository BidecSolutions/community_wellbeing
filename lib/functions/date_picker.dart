
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';


class Calender {
  RxString selectedMonthYear = ''.obs;
  RxString selectedDate = ''.obs;

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
      initialEntryMode: DatePickerEntryMode.calendar,
      helpText: 'Select Month and Year',
    );

    if (picked != null) {
      selectedDate.value =
      '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }


  Future<void> pickMonth(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showMonthPicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      selectedMonthYear.value =
      '${picked.year}-${picked.month.toString().padLeft(2, '0')}';
    }
  }
}
