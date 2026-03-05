import 'package:community_app/controllers/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/colors.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.0),
            end: Alignment(0.01, 0.0),
            colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            constraints: const BoxConstraints(maxWidth: 450),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter your email or phone number, and we'll send you instructions to reset your password.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: controller.emailOrPhoneController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.sendResetRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
                disabledBackgroundColor: Color(0xFF9674ED),
                disabledForegroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Send Reset Instructions",
                    style: TextStyle(fontSize: 18),
                  ),
                  if (controller.isLoading.value) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Back to Log in",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
