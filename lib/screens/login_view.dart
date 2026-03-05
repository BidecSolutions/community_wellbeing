import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/styles.dart';
import '../controllers/login_controller.dart';
import 'message_box.dart';

class LoginScreen extends StatelessWidget {
  // Changed to StatelessWidget
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.0),
            end: Alignment(0.01, 0.0),
            colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, left: 40.0, right: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Log in",
                style: AppStyles.headingH1,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              AutofillGroup(
                child: Column(
                  children: [
                    TextField(
                      controller: loginController.emailControllerText,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [
                        AutofillHints.username,
                      ], // ✅ Autofill hint
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        labelText: "Email or Phone",
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(
                      () => TextField(
                        controller: loginController.passwordControllerText,
                        obscureText: !loginController.isPasswordVisible.value,
                        autofillHints: const [
                          AutofillHints.password,
                        ], // ✅ Autofill hint
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.zero,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: loginController.togglePasswordVisibility,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/forget-password');
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: loginController.rememberMe.value,
                          onChanged: (val) {
                            loginController.rememberMe.value = val ?? false;
                          },
                        ),
                      ),
                      const Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Obx(() {
                if (loginController.errorMessage.value != null &&
                    loginController.errorMessage.value!.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showMessageBox(
                      Get.context!,
                      title: 'Error',
                      message: loginController.errorMessage.value!,
                      icon: Icons.error_outline,
                      buttonText: 'OK',
                    );
                    loginController.errorMessage.value =
                        null; // Reset error message
                  });
                  return const SizedBox.shrink(); // Return an empty widget for the Obx
                } else {
                  return const SizedBox.shrink(); // No error, return an empty widget
                }
              }),
              ElevatedButton(
                onPressed: () {
                  loginController.login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: Obx(
                  () =>
                      loginController.isLoading.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : const Text(
                            "Log in",
                            style: TextStyle(fontSize: 18),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
