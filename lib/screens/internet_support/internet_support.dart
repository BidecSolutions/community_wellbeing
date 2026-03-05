import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InternetSupport extends StatelessWidget {
  const InternetSupport({super.key});

  // final InternetSupportController controller = Get.put(InternetSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyAppBar(
                  showNotificationIcon: false,
                  showMenuIcon: true,
                  showBackIcon: true,
                  showBottom: true,
                  userName: false,
                  screenName: "IT Support & Repair",
                ),
                const SizedBox(height: 40),

                /// 🖥 Main Heading
                const Text(
                  'Apply For Internet Support',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                /// 📝 Subheading
                const Text(
                  'Apply For Free Or Low-Cost Internet To Stay Connected With Whānau, School, Or Work.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/apply_for_internet_support');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF1FF), // soft blue
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/internet_support/wifi.png',
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Get Help With Wi-Fi Or Mobile Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Fill Out This Quick Form And We’ll Connect You With A Safe Place As Soon As Possible.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.4,
                            fontFamily: AppFonts.secondaryFontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                /// 🛠 Bottom Section
                const Text(
                  'Electronics Help For Everyday Needs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Request Or Donate Essential Home Items — Or Get\nSmall Repairs To Keep Things Running.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                /// 🖼 Banner with Image & Label
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/appliances_repair');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/images/internet_support/image.png',
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: const Color.fromARGB(42, 0, 0, 0),
                          child: const Text(
                            'Appliances Repair',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                /// 🧾 Section Title
                const Text(
                  'Get Help With Devices & Digital Setup',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed('/book_a_setup_visit');
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.all(16),
                //     margin: const EdgeInsets.only(bottom: 12),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           height: 80,
                //           width: 60,
                //           padding: const EdgeInsets.all(12),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFFF0F4FF),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           child: Image.asset(
                //             'assets/images/internet_support/book_setup.png',
                //           ),
                //         ),
                //         const SizedBox(width: 12),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: const [
                //               Text(
                //                 'Book a setup help visit',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //               SizedBox(height: 4),
                //               Text(
                //                 'Book A Support Person To Help You At Home — With Wi-Fi, Phones, Laptops, Or Email.',
                //                 style: TextStyle(fontSize: 13, height: 1.4),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/digital_learning');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 60,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEDBDF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/internet_support/digital_learning.png',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Digital Learning Help',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Easy Guides To Help You Learn How To Use Your Phone, Email, Apps, And More.',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
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
      ),
    );
  }
}
