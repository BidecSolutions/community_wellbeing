import 'package:community_app/controllers/finance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/fonts.dart';

import '../widgets/snack_bar.dart';

class RequestForm extends StatefulWidget {
  final int id;

  const RequestForm(this.id, {super.key});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _financeController = Get.put(FinanceController());

  String status = "";

  int value = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.id == 1) {
      status = 'Behind on Rent or Bill';
    } else if (widget.id == 2) {
      status = 'Need Food Right Now';
    } else if (widget.id == 3) {
      status = 'Medical or Health Emergency';
    } else {
      status = 'Child or Baby Need';
    }

    _financeController.addressControllerText.clear();
    _financeController.emergencyControllerText.clear();
    _financeController.situationControllerText.clear();

    _financeController.emergencyControllerText.text = status;
    _financeController.selectedEmergencyId = widget.id;
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
                  "Tell Us What You Need Help With",
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                controller: _financeController.addressControllerText,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF5F5F0),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        TextFormField(
          readOnly: true,
          controller: _financeController.emergencyControllerText,
          decoration: InputDecoration(
            labelText: 'Emergency Type',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            fillColor: Color(0xFFF5F5F0),
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _financeController.situationControllerText,
          decoration: InputDecoration(
            labelText: 'Explain Your Situation',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            fillColor: Color(0xFFF5F5F0),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 20.0),
        Center(
          child: SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                bool result =
                    await _financeController.emergencyRequestProcess();
                if (result == true) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                  final snackBarShow = Snackbar(
                    title: 'Success',
                    message: _financeController.message.value.toString(),
                    type: 'success',
                  );
                  snackBarShow.show();
                } else {
                  final snackBarShow = Snackbar(
                    title: 'Failed',
                    message: _financeController.message.value.toString(),
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
