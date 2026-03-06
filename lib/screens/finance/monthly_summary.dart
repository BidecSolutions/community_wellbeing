import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/financial_summary.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:intl/intl.dart';
import '../widgets/drawer.dart';

class FinanceSummaryPage extends StatefulWidget {
  const FinanceSummaryPage({super.key});

  @override
  State<FinanceSummaryPage> createState() => _FinanceSummaryPageState();
}

class _FinanceSummaryPageState extends State<FinanceSummaryPage> {
  final FinanceSummaryController c = Get.put(FinanceSummaryController());
  final BorderRadius borderRadius = BorderRadius.circular(20);

  @override
  void initState() {
    super.initState();
    String currentMonth = DateFormat('MM').format(DateTime.now());
    c.fetchDataFromApi(month: currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* ────────── App-bar ────────── */
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Overview',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
                profile: true,
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),

              /* ────────── Monthly / Yearly toggle ────────── */
              Obx(
                () => Container(
                  width: 200,
                  height: 40,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: borderRadius,
                  ),
                  child: Row(
                    children: [
                      _toggleButton(
                        label: 'Monthly',
                        active: c.isMonthly.value,
                        onTap: () => c.switching(id: 1),
                      ),
                      _toggleButton(
                        label: 'Yearly',
                        active: !c.isMonthly.value,
                        onTap: () => c.switching(id: 2),
                      ),
                    ],
                  ),
                ),
              ),

              /* ────────── Summary card with dropdowns ────────── */
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: _summaryCard(context),
              ),

              /* ────────── Payment history heading ────────── */
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Your Payment History',
                    style: TextStyle(
                      fontFamily: AppFonts.secondaryFontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              /* ────────── Payment history grid ────────── */
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: _historyGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method for the toggle buttons (Monthly/Yearly).
  Widget _toggleButton({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: active ? AppColors.primaryColor : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFontFamily,
            color: active ? Colors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  /// Helper method for the summary card, including expenses, dropdowns, and pie chart.
  Widget _summaryCard(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD5EBFF), Color(0xFFF5F5F0)],
        ),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row for Expenses text and dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expenses texts
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Expenses',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.primaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          '\$${c.expenses.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Dropdowns (month or year)
                  Obx(() {
                    return (c.isMonthly.value)
                        ? _dropdown<String>(
                          value: c.selectedMonth.value,
                          items: c.months,
                          onChanged: (m) => c.setMonth(m!),
                        )
                        : _dropdown<int>(
                          value: c.selectedYear.value,
                          items: c.years,
                          onChanged: (y) => c.setYear(y!),
                        );
                  }),
                ],
              ),

              const SizedBox(height: 24),

              // Centered Pie chart below
              Center(
                child: SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(
                        () => PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 55,
                            sections: List.generate(
                              c.history.length,
                              (i) => PieChartSectionData(
                                // Corrected: Ensure 'amount' is always a double
                                value:
                                    (c.history[i]['amount'] as num).toDouble(),
                                color: c.colorForIndex(i),
                                title: '',
                                radius: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          'Savings\n\$${c.savings.toStringAsFixed(0)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.primaryFontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Generic helper method for dropdowns.
  Widget _dropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.white,
          style: const TextStyle(fontSize: 13, color: Colors.black),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.toString()),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  /// Helper method for the payment history grid.
  Widget _historyGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.history.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3 / 1.8,
      ),
      itemBuilder: (context, i) {
        final item = c.history[i];
        final color = c.colorForIndex(i);

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
                  CircleAvatar(radius: 10, backgroundColor: color),
                  const SizedBox(width: 10),
                  Text(
                    '${item['percent']}%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2.7),
              Transform.translate(
                offset: const Offset(20, 0),
                child: Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Transform.translate(
                offset: const Offset(20, 0),
                child: Text(
                  '\$${item['amount'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
