import 'package:community_app/controllers/budget_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:community_app/app_settings/fonts.dart';

import '../../functions/date_picker.dart';

class ExpenseFoam extends GetView<BudgetManagementController> {
  final getDate = Calender();
  ExpenseFoam({super.key});
  @override
  Widget build(BuildContext context) {
    controller.selectedMonthYear.value = '';
    controller.totalAmountTextBox.clear();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Add Your Monthly Income",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily, // Use your font
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () async {
            await getDate.pickMonth(Get.context!);
            controller.selectedMonthTextbox.text = getDate.selectedMonthYear.value;
          },
          child: AbsorbPointer(
            child: TextFormField(
              readOnly: true,
              controller: controller.selectedMonthTextbox,
              decoration: InputDecoration(
                labelText: 'Month',
                hintText: 'MM/YYYY',
                filled: true,
                fillColor: Color(0xFFF5F5F0),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.totalAmountTextBox,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: () async {
              bool result = await controller.insertMonthIncome();
              if (result == true) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
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
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ),
            child: Text(
              'Save Monthly Income',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
