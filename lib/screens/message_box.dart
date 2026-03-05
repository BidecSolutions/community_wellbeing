import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/debt_controller.dart';

class CustomMessageBox extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String buttonText;
  final String actionButtonText;
  final bool actionButton;
  final String actionController;

  const CustomMessageBox({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.buttonText = "OK",
    this.actionButtonText = "",
    this.actionButton = false,
    this.actionController = "",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(
                          icon,
                          size: 50.0,
                          color: Theme.of(context).primaryColor,
                        )
                        .animate()
                        .scaleXY(begin: 0.5, end: 1.0, duration: 300.ms)
                        .then()
                        .shakeY(),
                  const SizedBox(height: 15.0),
                  if (title.isNotEmpty) // Conditionally show title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (title.isNotEmpty) const SizedBox(height: 10.0),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (actionButton)
                        ElevatedButton(
                          onPressed: () {
                            final DebtManagement debtController =
                                Get.find<DebtManagement>();
                            debtController.debtManagementUpdate();

                            // Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: Text(
                            actionButtonText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .animate()
            .scaleXY(
              begin: 0.8,
              end: 1.0,
              duration: 200.ms,
              curve: Curves.easeInOut,
            )
            .fade(duration: 150.ms),
      ),
    );
  }
}

// Function to show the custom message box
void showMessageBox(
  BuildContext context, {
  String title = '', // Optional title with default empty string
  required String message,
  IconData? icon,
  String buttonText = '',
  bool actionButton = false,
  String actionButtonText = '',
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomMessageBox(
        title: title,
        message: message,
        icon: icon,
        buttonText: buttonText,
        actionButton: actionButton,
        actionButtonText: actionButtonText,
      );
    },
  );
}
