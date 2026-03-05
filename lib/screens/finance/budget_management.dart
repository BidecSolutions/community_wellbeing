import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/screens/finance/add_fixed_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import '../widgets/drawer.dart';
import 'monthly_income_foam.dart';
import '../../controllers/budget_management_controller.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:community_app/models/finance_model.dart';
import 'package:intl/intl.dart';

// Changed here: from StatelessWidget to StatefulWidget
class BudgetManagement extends StatefulWidget {
  const BudgetManagement({super.key});

  @override
  State<BudgetManagement> createState() => _BudgetManagementState();
}

class _BudgetManagementState extends State<BudgetManagement> {
  final BudgetManagementController controller =
      Get.find<BudgetManagementController>();
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    controller.monthlyIncome();
    controller.fetchCategories();
    controller.listDailyExpense();
    controller.calculateRemainingBalance();
    controller.fixedExpenseList();
    controller.remainBalance();
  }

  @override
  Widget build(BuildContext context) {
    controller.descriptionTextbox.clear();
    controller.dailyExpenseAmountTextbox.clear();
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: true,
                showBackIcon: true,
                showBottom: false,
                userName: false,
                screenName: "Budget Planner",
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            child: Obx(
                              () => _buildInfoCard(
                                backgroundColor: Color(0xFFCDFFDA),
                                title: 'Total Monthly Income',
                                value:
                                    '\$${controller.totalMonthlyIncome.value.toStringAsFixed(2)}',
                                subtitle: 'Add your Monthly Income',
                              ),
                            ),
                            onTap: () {
                              if (controller.totalMonthlyIncome.value == 0) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          insetPadding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.zero,
                                          clipBehavior: Clip.none,
                                          content: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            width: constraints.maxWidth * 0.9,
                                            height: constraints.maxHeight * 0.4,
                                            child: SingleChildScrollView(
                                              child: ExpenseFoam(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                final snackBarShow = Snackbar(
                                  title: 'Failed',
                                  message: 'Already Inserted for this month',
                                  type: 'error',
                                );
                                snackBarShow.show();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: GestureDetector(
                            child: Obx(
                              () => _buildInfoCard(
                                backgroundColor: Color(0xFFFEDBDF),
                                title: 'Fixed Expenses',
                                value:
                                    '\$ ${controller.fixedExpenses.value.toStringAsFixed(2)}',
                                subtitle: 'Add your Fixed Expenses',
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        clipBehavior: Clip.none,
                                        content: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          width: constraints.maxWidth * 0.9,
                                          height: constraints.maxHeight * 0.8,
                                          child: SingleChildScrollView(
                                            child: FixedExpenseFoam(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Obx(() {
                      return _buildRemainingBalanceCard(
                        remainingBalance: controller.remainingBalance.value,
                      );
                    }),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Add New Expenses',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 3),
                              Obx(
                                () => DropdownButtonFormField<int>(
                                  value: controller.selectedCategoryId.value,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    hint: Text('Category'),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                  ),
                                  items:
                                      controller.apiCategory.map((
                                        Category category,
                                      ) {
                                        return DropdownMenuItem<int>(
                                          value: category.id,
                                          child: Text(category.name),
                                        );
                                      }).toList(),
                                  onChanged: (int? newId) {
                                    controller.selectedCategoryId.value = newId;

                                    final selectedCategory = controller
                                        .apiCategory
                                        .firstWhereOrNull(
                                          (category) => category.id == newId,
                                        );

                                    if (selectedCategory != null) {
                                      controller.selectedCategoryName.value =
                                          selectedCategory.name;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: controller.dailyExpenseAmountTextbox,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              labelText: 'Total Amount',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller:
                          controller
                              .descriptionTextbox, // <-- added controller here
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool result = await controller.insertDailyExpense();
                          if (result == true) {
                            controller.descriptionTextbox.clear();
                            controller.dailyExpenseAmountTextbox.clear();
                            controller.listDailyExpense();
                            final snackBarShow = Snackbar(
                              title: 'Success',
                              message: controller.message.value.toString(),
                              type: 'success',
                            );
                            snackBarShow.show();
                          } else {
                            final snackBarShow = Snackbar(
                              title: 'Failed',
                              message: controller.message.value.toString(),
                              type: 'error',
                            );
                            snackBarShow.show();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Amount',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final totalAmount = controller.expenseList.fold<double>(
                        0.0,
                        (sum, item) => sum + item.amount,
                      );
                      controller.expenseTotal.value = totalAmount;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.expenseList.length +
                            1, // +1 for total row
                        itemBuilder: (context, index) {
                          if (index == controller.expenseList.length) {
                            // Total row
                            return Container(
                              color: Colors.grey.shade300,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Expanded(
                                    child: Text(''),
                                  ), // Empty space for date
                                  const Expanded(
                                    child: Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\$${totalAmount.toStringAsFixed(2)}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final expense = controller.expenseList[index];
                          final isEven = index % 2 == 0;
                          final backgroundColor =
                              isEven ? Colors.grey.shade50 : Colors.white;

                          return Container(
                            color: backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    DateFormat(
                                      'dd-MMM-yyyy',
                                    ).format(DateTime.parse(expense.date)),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(child: Text(expense.category)),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    '\$${expense.amount.toStringAsFixed(2)}',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),

                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Get.toNamed('/finance-monthly-summary');
                        },
                        child: const Text('View Detail'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

Widget _buildInfoCard({
  required Color backgroundColor,
  required String title,
  required String value,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRemainingBalanceCard({required dynamic remainingBalance}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(-0.99, 0.0),
        end: Alignment(0.01, 0.0),
        colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Remaining Balance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            Text(
              '\$${(remainingBalance is num ? remainingBalance.toStringAsFixed(2) : '0.00')}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: const Text(
            'See what\'s left after subtraction your expenses from your income, your available budget for saving,investment.',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black,
              fontFamily: AppFonts.primaryFontFamily,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ),
  );
}
