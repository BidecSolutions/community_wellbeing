import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../app_settings/settings.dart';
import '../models/finance_model.dart';
import '../screens/profile/change_password.dart';

class DebtManagement extends GetxController {
  final errorMessage = "Are You sure You Want to Pay?";
  final bankNameTextbox = TextEditingController();
  final pendingAmountTextbox = TextEditingController();
  final totalAmountTextbox = TextEditingController();
  final message = RxnString();
  RxString selectedMonthYear = ''.obs;

  final RxList<DebtManagementList> debtList = <DebtManagementList>[].obs;

  final selectedDateTextbox = TextEditingController();

  Future<bool> edit(Map<String, dynamic> obj) async {
    final body = jsonEncode(obj);
    final Map<String, dynamic> decodedMap =
        jsonDecode(body) as Map<String, dynamic>;
    final int? id = int.tryParse(decodedMap['id']);

    final urlFind = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/find-all-expenses',
    );
    final api = await http.get(
      urlFind,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    final apiResponse = jsonDecode(api.body);
    final income =
        apiResponse['result']['total_income'][0]['total_amount'] ?? 0.0;
    final totalExpense =
        apiResponse['result']['total_daily_expense']['totalAmount'] ?? 0.0;
    final totalFixed = apiResponse['result']['total_fixed_expense'] ?? 0.0;
    final incomeVal =
        (income is num)
            ? income.toDouble()
            : double.tryParse(income.toString()) ?? 0.0;
    final expenseVal =
        (totalExpense is num)
            ? totalExpense.toDouble()
            : double.tryParse(totalExpense.toString()) ?? 0.0;
    final fixedVal =
        (totalFixed is num)
            ? totalFixed.toDouble()
            : double.tryParse(totalFixed.toString()) ?? 0.0;
    final debtAmount = double.tryParse(decodedMap['pendingAmount'].toString());
    final balance = incomeVal - (expenseVal + fixedVal + debtAmount!);
    if (balance < 0) {
      message.value = 'not allowed. Insufficient Amount';
      return false;
    }
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/pay-debt-amount',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"id": id}),
    );
    if (response.statusCode == 201) {
      message.value = 'Amount paid Successfully...!';
      return true;
    } else {
      message.value = 'Request not sent';
      return false;
    }
  }

  Future<void> pay(Map<String, dynamic> lister) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> insertDebtManagement() async {
    final bankName = bankNameTextbox.text.toString();
    final pendingAmount = int.tryParse(pendingAmountTextbox.text);
    final totalAmount = int.tryParse(totalAmountTextbox.text);
    if (bankName.isEmpty) {
      message.value = 'Enter Card No';
      return false;
    }
    if (selectedDateTextbox.text.isEmpty) {
      message.value = 'Select Date';
      return false;
    }
    if (pendingAmount == null) {
      message.value = 'Enter Pending Amount';
      return false;
    }
    if (totalAmount == null) {
      message.value = 'Enter Total Amount';
      return false;
    }
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/debt-management-create',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "bank_name": bankName,
        "due_date": selectedDateTextbox.text,
        "pending_amount": pendingAmount,
        "total_amount": totalAmount,
      }),
    );
    if (response.statusCode == 201) {
      message.value = 'Debt Added Successfully...!';
      return true;
    } else {
      message.value = 'Request Not Sent Try Again';
      return false;
    }
  }

  Future debtManagementList() async {
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}monthly-income/debt-management-list',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = jsonDecode(response.body);
        final List<dynamic> data = apiResponse['result'] ?? [];
        debtList.value =
            data.map((item) => DebtManagementList.fromJson(item)).toList();
      }
    } catch (e) {
      message.value = 'Request Not Sent';
      return false;
    }
  }

  Future debtManagementUpdate() async {

  }
}
