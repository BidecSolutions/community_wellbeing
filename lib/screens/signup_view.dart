// lib/screen/signup/signup_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/styles.dart';

import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  // Changed to StatefulWidget
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState(); // Create the State class
}

class SignupScreenState extends State<SignupScreen> {
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.0),
            end: Alignment(0.01, 0.0),
            colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 41),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Sign up",
                        style: AppStyles.headingH1,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Create an account to get started",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      TextField(
                        controller: controller.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                      ),
                      Obx(
                        () =>
                            controller.nameError.value.isEmpty
                                ? const SizedBox(
                                  height: 20,
                                ) // reserve height even if no error
                                : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    controller.nameError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                      ),

                      const SizedBox(height: 8),

                      // Email TextField + Error
                      TextField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                      ),
                      Obx(
                        () =>
                            controller.emailError.value.isEmpty
                                ? const SizedBox(height: 20)
                                : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    controller.emailError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                      ),

                      const SizedBox(height: 8),

                      // Phone TextField + Error
                      TextField(
                        controller: controller.phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                      ),
                      Obx(
                        () =>
                            controller.phoneError.value.isEmpty
                                ? const SizedBox(height: 20)
                                : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    controller.phoneError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                      ),

                      const SizedBox(height: 8),

                      // Password TextField + Error with visibility toggle
                      Obx(
                        () => TextField(
                          controller: controller.password,
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.zero,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.togglePassword,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () =>
                            controller.passwordError.value.isEmpty
                                ? const SizedBox(height: 20)
                                : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    controller.passwordError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                      ),

                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: () {
                          controller.signup();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 18),
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
}
