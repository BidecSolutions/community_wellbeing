import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_settings/colors.dart';
import '../../controllers/debt_controller.dart';
import '../../functions/date_picker.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/snack_bar.dart';
import 'package:community_app/models/finance_model.dart';

final DebtManagement controller = Get.find<DebtManagement>();
final getDate = Calender();
class DebtItem extends StatefulWidget {
  final DebtManagementList debt; // Use model class here
  final int index;

  const DebtItem({super.key, required this.debt, required this.index});

  @override
  DebtItemState createState() => DebtItemState();
}

class DebtItemState extends State<DebtItem> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController pendingAmountController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();

  // Example of local state you might manage if it were stateful
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    cardNumberController.text = widget.debt.cardNumber;
    pendingAmountController.text = widget.debt.pendingAmount.toString();
    dueDateController.text = widget.debt.dueDate;
  }

  @override
  void didUpdateWidget(covariant DebtItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the debt object itself changes (e.g., from an update from the controller),
    // update the text controllers to reflect the new data.
    if (widget.debt != oldWidget.debt) {
      cardNumberController.text = widget.debt.cardNumber;
      pendingAmountController.text = widget.debt.pendingAmount.toString();
      dueDateController.text = widget.debt.dueDate;
      // totalAmountController.text = widget.debt.totalAmount.toString();
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    cardNumberController.dispose();
    pendingAmountController.dispose();
    dueDateController.dispose();
    totalAmountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.debt.id),
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.0),
            end: Alignment(0.01, 0.0),
            colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
          ),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        child: const Icon(Icons.message, color: Colors.black),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.0),
            end: Alignment(0.01, 0.0),
            colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
          ),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.edit, color: Colors.black),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          //Edit Here
          // final shouldDismiss = await _showEditDialog(context);
          // return shouldDismiss;
        }
        if (direction == DismissDirection.startToEnd &&
            widget.debt.status != 2) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                          Icons.warning,
                          size: 50.0,
                          color: Theme.of(dialogContext).primaryColor,
                        )
                        .animate()
                        .scaleXY(begin: 0.5, end: 1.0, duration: 300.ms)
                        .then()
                        .shakeY(),
                    const SizedBox(height: 15.0),
                    const Text(
                      "Confirmation ?",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Are you sure you want to pay",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final updatedDebt = {
                                  'cardNumber': cardNumberController.text,
                                  'pendingAmount':
                                      double.tryParse(
                                        pendingAmountController.text,
                                      ) ??
                                      widget.debt.pendingAmount,
                                  'dueDate': dueDateController.text,
                                  'totalAmount':
                                      double.tryParse(
                                        totalAmountController.text,
                                      ) ??
                                      widget.debt.totalAmount,
                                  'id': widget.debt.id,
                                };
                                final result = await controller.edit(
                                  updatedDebt,
                                );
                                if (result == true) {
                                  await controller.debtManagementList();
                                  final snackBarShow = Snackbar(
                                    title: 'Success',
                                    message:
                                        controller.message.value.toString(),
                                    type: 'success',
                                  );
                                  snackBarShow.show();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                } else {
                                  final snackBarShow = Snackbar(
                                    title: 'Error',
                                    message:
                                        controller.message.value.toString(),
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
                                  vertical: 15.0,
                                ),
                              ),
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                ),
                              ),
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          final snackBarShow = Snackbar(
            title: 'Action Denied',
            message: "already Paid this amount",
            type: 'warning',
          );
          snackBarShow.show();
        }
        return null;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          // Use a Stack to position the label
          children: [
            Column(
              // Existing content of the container
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.debt.cardNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pending: \$${widget.debt.pendingAmount.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      'Due Date:      ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(widget.debt.dueDate))}',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '\$${widget.debt.totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                // Example of using local state
                if (_showDetails)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Additional details here...',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _showDetails = !_showDetails; // Toggle local state
                      });
                    },
                    child: Text(_showDetails ? 'Hide Details' : 'Show Details'),
                  ),
                ),
              ],
            ),
            Positioned(
              // Position the label
              top: 0,
              right: 0,
              child: _buildStatusLabel(
                widget.debt.status,
              ), // Access widget.debt
            ),
          ],
        ),
      ),
    );
  }
}

// DebtListScreen remains the same as your previous conversion
class DebtListScreen extends StatefulWidget {
  const DebtListScreen({super.key});

  @override
  DebtListScreenState createState() => DebtListScreenState();
}

class DebtListScreenState extends State<DebtListScreen> {
  @override
  void initState() {
    super.initState();
    controller.debtManagementList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: true,
                showBackIcon: true,
                showBottom: false,
                userName: false,
                screenName: "Debt Management",
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.bankNameTextbox,
                            decoration: const InputDecoration(
                              labelText: 'Card Number',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xFFF5F5F0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                             await getDate.pickDate(Get.context!);
                             controller.selectedDateTextbox.text = getDate.selectedDate.value;
                            },
                            child: AbsorbPointer(
                              child:TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Select Due Date',
                                  hintText: 'YYYY-MM-DD',
                                  filled: true,
                                  fillColor: Color(0xFFF5F5F0),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                controller: controller.selectedDateTextbox,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.pendingAmountTextbox,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Pending Amount',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xFFF5F5F0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: controller.totalAmountTextbox,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Total Amount',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xFFF5F5F0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool result =
                                await controller.insertDebtManagement();
                            if (result == true) {
                              controller.bankNameTextbox.clear();
                              controller.pendingAmountTextbox.clear();
                              controller.totalAmountTextbox.clear();
                              controller.selectedMonthYear.value = '0000-00-00';
                              final snackBarShow = Snackbar(
                                title: 'Success',
                                message: controller.message.value.toString(),
                                type: 'success',
                              );
                              snackBarShow.show();
                              controller.debtManagementList();
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
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.debtList.length,
                  itemBuilder: (context, index) {
                    final debt = controller.debtList[index];
                    return DebtItem(debt: debt, index: index);
                  },
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

Widget _buildStatusLabel(int status) {
  Color labelColor;
  String labelText;
  Color textColor;
  if (status == 1) {
    labelColor = Colors.orange;
    labelText = 'Pending';
    textColor = Colors.white;
  } else if (status == 2) {
    labelColor = Colors.green;
    labelText = 'Paid';
    textColor = Colors.white;
  } else {
    labelColor = Colors.red;
    labelText = 'Overdue';
    textColor = Colors.white;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: labelColor,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      labelText,
      style: TextStyle(
        color: textColor,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
