import 'package:community_app/app_settings/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:get/get.dart';
import '../../controllers/budget_management_controller.dart';
import 'package:get_storage/get_storage.dart';

class FixedExpenseFoam extends StatelessWidget {
  final box = GetStorage();
  final BudgetManagementController controller = Get.find<BudgetManagementController>();
  FixedExpenseFoam({super.key});

  @override
  Widget build(BuildContext context) {

    controller.shoppingTextbox.text = (box.read('shopping') ?? 0.0).toString();
    controller.homeTextbox.text = (box.read('home') ?? 0.0).toString();
    controller.medicalTextbox.text = (box.read('medical') ?? 0.0).toString();
    controller.restaurantTextbox.text = (box.read('restaurant') ?? 0.0).toString();
    controller.travelingTextbox.text = (box.read('traveling') ?? 0.0).toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ), // top and bottom margin
            child: Text(
              'Add Your Expenses',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.secondaryFontFamily,
              ),
            ),

          ),
        ),

        Text(
          'Categories',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.secondaryFontFamily,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Shopping",
                  prefixIcon: Image.asset('assets/images/Shopping.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.shoppingTextbox,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  suffixText: "\$",
                  labelText: "Add Amount",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Home",
                  prefixIcon: Image.asset('assets/images/home-2.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller.homeTextbox,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Add Amount",
                  suffixText: "\$",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Medical",
                  prefixIcon: Image.asset('assets/images/medical.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller.medicalTextbox,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Add Amount",
                  suffixText: "\$",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),

                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Restaurant",
                  prefixIcon: Image.asset('assets/images/Restuarant.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.restaurantTextbox,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Add Amount",
                  suffixText: "\$",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,

                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Traveling",
                  prefixIcon: Image.asset('assets/images/Travel.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.travelingTextbox,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Add Amount",
                  suffixText: "\$",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Emi/Loan",
                  prefixIcon: Image.asset('assets/images/emi.png'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Add Amount",
                  suffixText: "\$",
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
        Center(
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () async {
                  bool result = await controller.insertFixedExpense();
                  if(result == true){
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    controller.listDailyExpense();
                    final snackBarShow = Snackbar(
                      title: 'Success',
                      message: controller.message.value.toString(),
                      type: 'success',
                    );
                    snackBarShow.show();
                  }
                  else{
                    final snackBarShow = Snackbar(
                      title: 'Failed',
                      message: controller.errorMessage.toString(),
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
