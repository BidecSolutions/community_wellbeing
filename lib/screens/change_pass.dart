import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/controllers/otp_controller.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Toggles for password visibility
  final RxBool _passwordVisible = false.obs;

  final RxBool _confirmPasswordVisible = false.obs;

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.emailController.text = controller.email;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  // Email field
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) => controller.email = value,
                  ),
                  const SizedBox(height: 20),

                  // New password
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: !_passwordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Enter New Password',
                        hintText: '8 symbols at least',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => _passwordVisible.toggle(),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm password
                  Obx(
                    () => TextFormField(
                      controller: confirmPasswordController,
                      obscureText: !_confirmPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => _confirmPasswordVisible.toggle(),
                        ),
                      ),
                      validator: (value) {
                        if (value != controller.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.email =
                              controller.emailController.text.trim();
                          controller.confirmPassword =
                              confirmPasswordController.text.trim();
                          controller.newPassword =
                              controller.passwordController.text.trim();
                          controller.resetPassword();
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
