import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/drawer.dart';

class FinanceYearlySummary extends StatelessWidget {
  FinanceYearlySummary({super.key});
  // Dummy data for expenses and savings (replace with your actual data)
  final double totalExpenses = 457080;
  final double totalSavings = 20000;

  final List<Map<String, dynamic>> paymentHistory = [
    {
      'color': Color(0xFF9FFFB7),
      'percent': 20,
      'name': 'Home',
      'amount': '\$18000',
    },
    {
      'color': Color(0xFFFF858F),
      'percent': 25,
      'name': 'Medical',
      'amount': '\$13500',
    },
    {
      'color': Color(0xFF56B4EE),
      'percent': 15,
      'name': 'Shopping',
      'amount': '\$11700',
    },
    {
      'color': Color(0xFFEE5656),
      'percent': 10,
      'name': 'Restaurant',
      'amount': '\$9000',
    },
    {
      'color': Color(0xFF5681EE),
      'percent': 17,
      'name': 'EMI (Loan)',
      'amount': '\$16200',
    },
    {
      'color': Color(0xFFEE56EB),
      'percent': 13,
      'name': 'Travelling',
      'amount': '\$21600',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- Scrollable AppBar + Search Start --
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: true,
                showBackIcon: true,
                showBottom: false,
                userName: false,
                screenName: "Monthly Overview",
                bottom: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // --- Scrollable Appbar End--
              // --- Button Start --
              Container(
                width: 200,
                height: 40,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: borderRadius,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/finance-monthly-summary');
                        },
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            // decoration: TextDecoration.underline,
                            fontFamily:
                                AppFonts.primaryFontFamily, // <--- updated here
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: borderRadius,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // No controller, just a button
                          },
                          child: Text(
                            'Yearly',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily:
                                  AppFonts
                                      .primaryFontFamily, // <--- updated here
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // --- Button End --
              // --- chart summary start --
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFD5EBFF), // Top color
                        Color(0xFFF5F5F0), // Bottom color
                      ],
                    ),
                  ),
                  child: Card(
                    elevation: 0,
                    color:
                        Colors
                            .transparent, // Important to let gradient show through
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // --- Header Row ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your Expenses',
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value:
                                        '2025', // Set your default value here
                                    iconSize: 16,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 16,
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.primaryFontFamily,
                                      color: Colors.black,
                                    ),
                                    items:
                                        <String>[
                                          '2022',
                                          '2023',
                                          '2024',
                                          '2025',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      // handle dropdown change
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // --- Expenses Value ---
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '\$${totalExpenses.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: AppFonts.primaryFontFamily,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // --- Pie Chart ---
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 60,
                                    sections: [
                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFF9FFFB7),
                                        title: '',
                                        radius: 20,
                                      ),

                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFFFF858F),
                                        title: '',
                                        radius: 25,
                                      ),

                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFF56B4EE),
                                        title: '',
                                        radius: 15,
                                      ),
                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFFEE5656),
                                        title: '',
                                        radius: 10,
                                      ),
                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFF5681EE),
                                        title: '',
                                        radius: 17,
                                      ),
                                      PieChartSectionData(
                                        value: totalExpenses,
                                        color: Color(0xFFEE56EB),
                                        title: '',
                                        radius: 13,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Your Savings\n\$${totalSavings.toStringAsFixed(0)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.primaryFontFamily,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //--- chart summary end --

              // --- Your Payment History Start --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Payment History',
                    style: TextStyle(
                      fontFamily: AppFonts.primaryFontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentHistory.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final item = paymentHistory[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: item['color'],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${item['percent']}%',
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          // Amount under percentage with position offset
                          Transform.translate(
                            offset: const Offset(20, 0), // Move 8 pixels left
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['name'],
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Name under amount with position offset
                          Transform.translate(
                            offset: const Offset(20, 0), // Move 8 pixels left
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['amount'],
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // --- Your Payment History End --
            ], // children
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
