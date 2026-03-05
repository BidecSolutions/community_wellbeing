import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../app_settings/settings.dart';
import '../models/finance_model.dart';
import 'package:get_storage/get_storage.dart';

class BudgetManagementController extends GetxController {
  DateTime? selectedDate;
  var totalMonthlyIncome = 0.0.obs;
  var fixedExpenses = 0.0.obs;
  var remainingBalance = 0.0.obs;
  var expenseTotal = 0.0.obs;
  final message = RxnString();
  final errorMessage = RxnString();
  final box = GetStorage();
  final RxList<ExpenseList> expenseList = <ExpenseList>[].obs;
  var apiCategory = <Category>[].obs;
  var isLoading = false.obs;
  final totalDailyExpense = 0.00.obs;
  var lastKeyTyped = ''.obs;

  //for insert Monthly Income
  final totalAmountTextBox = TextEditingController();

  //for insert Daily Expenses
  final descriptionTextbox = TextEditingController();
  final dailyExpenseAmountTextbox = TextEditingController();
  //End

  final selectedMonthTextbox = TextEditingController();

  //for fixed Expense
  final shoppingTextbox = TextEditingController();
  final homeTextbox = TextEditingController();
  final medicalTextbox = TextEditingController();
  final restaurantTextbox = TextEditingController();
  final travelingTextbox = TextEditingController();
  //End

  final selectedCategoryId = Rx<int?>(null);
  final selectedCategoryName = Rx<String?>(null);

  RxString selectedMonthYear = ''.obs;

  Future<void> pickMonthYear(BuildContext context) async {
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
      selectedMonthYear.value =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}';
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

  //for calculation
  Future<bool> calculateRemainingBalance({
    double? expenseValue,
    double? fixedExpenseValue,
  }) async {
    double totalIncome = totalMonthlyIncome.value;
    double expenseInput = expenseValue ?? 0.0;
    double totalExpense = expenseTotal.value + expenseInput;
    double totalRemainBalance = totalIncome - totalExpense;

    if (totalRemainBalance < 0) {
      errorMessage.value =
          "Please Enter a Valid Amount \n Your Monthly Income is ($totalIncome) \n Your Total Expense was ($totalExpense)";
      return false;
    } else {
      remainBalance();
      return true;
    }
  }

  //Api for insert monthly income
  Future<bool> insertMonthIncome() async {
    if (totalAmountTextBox.text.isEmpty) {
      message.value = 'Please enter Amount';
      return false;
    }

    if (selectedMonthTextbox.text.isEmpty) {
      message.value = 'Select month';
      return false;
    }

    final url = Uri.parse('${AppSettings.baseUrl}monthly-income/create');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "total_amount": int.tryParse(totalAmountTextBox.text),
        "current_month": selectedMonthTextbox.text,
      }),
    );
    if (response.statusCode == 201) {
      message.value =
          'Your monthly Income of \n month  ${selectedMonthYear.value} save Successfully..';
      totalMonthlyIncome.value =
          double.tryParse(totalAmountTextBox.text) ?? 0.0;
      remainBalance();
      return true;
    } else {
      message.value = 'Request Not Sent Try Again';
      return false;
    }
  }

  //Api for get monthly details
  Future<void> monthlyIncome() async {
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/current-month-income',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"user_id": '${box.read('user_id')}'}),
    );
    final apiResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      final data = apiResponse['data'];
      if (data != null && data.isNotEmpty) {
        double totalAmount =
            double.tryParse(data[0]['total_amount'] ?? '0') ?? 0.0;
        // Correctly assign double value to the reactive variable
        totalMonthlyIncome.value = totalAmount;
      } else {
        totalMonthlyIncome.value = 0.0;
      }
    }
  }

  //Api for Category Get
  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
        '${AppSettings.baseUrl}monthly-income/expense-category',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List data = responseBody['data'];
        apiCategory.value =
            data.map((item) => Category.fromJson(item)).toList();
      }
    } catch (e) {
           e;
    } finally {
      isLoading.value = false;
    }
  }

  //Api for Insert Daily Expense
  Future<bool> insertDailyExpense() async {
    final expenseAmount = dailyExpenseAmountTextbox.text.toString();
    final expenseDescription = descriptionTextbox.text.toString();
    final expenseType = selectedCategoryId.value;
    if (expenseAmount.isEmpty) {
      message.value = 'Please enter Amount';
      return false;
    }
    if (expenseType == null) {
      message.value = 'Select Expense Type';
      return false;
    }
    final process = await calculateRemainingBalance(
      expenseValue: double.tryParse(expenseAmount),
    );

    if (process == false) {
      message.value = errorMessage.toString();
      return false;
    }
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/insert-daily-expense',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "expense_amount": int.tryParse(expenseAmount),
        "desciption": expenseDescription,
        "expense_category_id": expenseType,
      }),
    );
    if (response.statusCode == 201) {
      message.value = 'Expense Added Successfully...!';
      return true;
    } else {
      message.value = 'Request Not Sent Try Again';
      return false;
    }
  }

  //Api for Get list of Daily Expense
  Future listDailyExpense() async {
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/daily-expense-list',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final List<dynamic> data = responseJson['data'] ?? [];
      expenseList.value =
          data.map((item) => ExpenseList.fromJson(item)).toList();
      totalDailyExpense.value = 0.00;
      for (var i in expenseList) {
        totalDailyExpense.value += i.amount;
      }
      remainBalance();
    } else {
      expenseList.value = [];
    }
  }

  //APi for Insert Fixed Expense
  Future<bool> insertFixedExpense() async {
    final shopping = int.tryParse(shoppingTextbox.text) ?? 0;
    final home = int.tryParse(homeTextbox.text) ?? 0;
    final medical = int.tryParse(medicalTextbox.text) ?? 0;
    final restaurant = int.tryParse(restaurantTextbox.text) ?? 0;
    final traveling = int.tryParse(travelingTextbox.text) ?? 0;
    final expenseAmount = (shopping + home + medical + restaurant + traveling);

    final process = await calculateRemainingBalance(
      expenseValue: expenseAmount.toDouble(),
    );

    if (process == false) {
      message.value = errorMessage.toString();
      return false;
    }
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/add-fixed-expenses',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode([
        {"amount": shopping},
        {"amount": home},
        {"amount": medical},
        {"amount": restaurant},
        {"amount": traveling},
      ]),
    );
    if (response.statusCode == 201) {
      fixedExpenseList();
      message.value = 'Fixed Expense Added Successfully...!';
      return true;
    } else {
      message.value = 'Request Not Sent Try Again';
      return false;
    }
  }

  //APi for get total of fixed Expense and textbox data
  Future fixedExpenseList() async {
    final url = Uri.parse(
      '${AppSettings.baseUrl}monthly-income/fixed-expenses-list',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    final apiResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      double totalValue = (apiResponse['result']['total'] as int).toDouble();
      fixedExpenses.value = totalValue;
      box.remove('shopping');
      box.remove('home');
      box.remove('medical');
      box.remove('restaurant');
      box.remove('traveling');
      final targetCategories = {
        'Shopping': 'shopping',
        'Home': 'home',
        'Medical': 'medical',
        'Restaurant': 'restaurant',
        'Traveling': 'traveling',
      };
      for (var item in apiResponse['result']['data']) {
        final category = item['category'];
        final amount = item['amount'];
        if (targetCategories.containsKey(category)) {
          await box.write(targetCategories[category]!, amount);
        }
      }
      remainBalance();
    } else {
      fixedExpenses.value = 0.0;
    }
  }

  Future<void> remainBalance() async {
    final remain = totalDailyExpense.value + fixedExpenses.value;
    remainingBalance.value = totalMonthlyIncome.value - remain;
  }
}
