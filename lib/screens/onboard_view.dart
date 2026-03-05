
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/styles.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F0),
      body: Stack(
        children: [
          // Image covering the top portion
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Image.asset(
                "assets/images/onboard02.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content Section (text and buttons)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F0),
                // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 0.0),
                    child: Text(
                      "Welcome To TE POU HIHIRI",
                      style: AppStyles.headingMedium.copyWith(
                        // fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 0.0,
                      right: 10.0,
                    ),

                    child: Text(
                      "Supporting Whānau With Trusted Tools For Parenting, Learning, Health, And Community Care — All In One Place.",
                      style: AppStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140, // increased width
                        child: OutlinedButton(
                          onPressed: () {
                            Get.offNamed('/login');

                            // showMessageBox(
                            //   context,
                            //   title: 'Success',
                            //   message: 'Request Generated Successfully...!',
                            //   icon: Icons.check_circle_outline,
                            // );
                          },
                          style: OutlinedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ), // increased padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: const Text("Log in"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 140, // increased width
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5837E8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ), // increased padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text("Sign up"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
