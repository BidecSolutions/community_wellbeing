import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../app_settings/settings.dart';
import '../screens/profile/change_password.dart';

class FinanceSummaryController extends GetxController {
  final isMonthly = true.obs;
  void setMonthly() => isMonthly.value = true;
  void setYearly()  => isMonthly.value = false;
  final List<String> months = List.generate(
    12, (i) => DateFormat.MMMM().format(DateTime(0, i + 1)),
  );
  final List<int> years = List.generate(4, (i) => 2025 + i);
  final RxString selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final RxInt selectedYear = DateTime.now().year.obs;
  final RxList<Map<String, dynamic>> _monthly = <Map<String, dynamic>>[].obs;



 void switching({int? id}){
     if(id == 1){
       isMonthly.value = true;
       String currentMonth = DateFormat('MMMM').format(DateTime.now());
       String result = convertMonthNumberToName(currentMonth);
       fetchDataFromApi(month: result);
     }
     else{
       isMonthly.value = false;
       fetchYearly(year: selectedYear.value.toString());
     }
  }

  void setMonth(String m) {
    selectedMonth.value = m;
    _updateData();
  }

  void setYear(int y) {
    selectedYear.value = y;
    _updateYearData();
  }

  String convertMonthNumberToName(String monthNumber) {
    final months = {
      "January": "01",
      "February": "02",
      "March": "03",
      "April": "04",
      "May": "05",
      "June": "06",
      "July": "07",
      "August": "08",
      "September": "09",
      "October": "10",
      "November": "11",
      "December": "12",
    };

    return months[monthNumber] ?? "Invalid month";
  }

  void _updateData() {
    String result = convertMonthNumberToName(selectedMonth.value);
    fetchDataFromApi(month: result);
  }


  void _updateYearData(){
    fetchYearly(year: selectedYear.value.toString());
  }

  final expenses = 0.obs;
  final savings  = 0.obs;


  Future<void> fetchDataFromApi({String? month}) async {
    final url = Uri.parse('${AppSettings.baseUrl}monthly-income/chart-summary');
    final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "month":month
      }),
    );
    if (response.statusCode == 201) {
      final apiResponse = jsonDecode(response.body);

      _monthly.clear();
      final List<dynamic> data = apiResponse['expesne_list'];
      _monthly.assignAll(data.map((item) => item as Map<String, dynamic>).toList());
      expenses.value = apiResponse['total_expense_amount'];
      savings.value =  apiResponse['saving'];
    }
    else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchYearly({String? year}) async {
    final url = Uri.parse('${AppSettings.baseUrl}monthly-income/chart-summary-yearly');
    final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "year":year
      }),
    );
    if (response.statusCode == 201) {
      final apiResponse = jsonDecode(response.body);

      _monthly.clear();
      final List<dynamic> data = apiResponse['expesne_list'];
      _monthly.assignAll(data.map((item) => item as Map<String, dynamic>).toList());
      expenses.value = apiResponse['total_expense_amount'];
      savings.value =  apiResponse['saving'];
    }
    else {
      throw Exception('Failed to load data');
    }
  }



  List<Map<String, dynamic>> get history => _monthly;

  /* ───────── colors (unchanged) ───────── */
  final List<Color> _palette = const [
    Color(0xFF9FFFB7), Color(0xFFFF858F), Color(0xFF56B4EE),
    Color(0xFFEE56EB), Color(0xFFFFC107), Color(0xFF8BC34A),
    Color(0xFF00BCD4), Color(0xFFCDDC39), Color(0xFFE91E63),
    Color(0xFF009688),
  ];
  Color colorForIndex(int i) => _palette[i % _palette.length];
}
