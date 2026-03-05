import 'package:community_app/controllers/finance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/app_settings/fonts.dart';
import '../widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:community_app/screens/widgets/app_bar.dart';

class FinancialSupportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> supportOptions = [
    {
      'title': 'Behind on Rent or Bills',
      'color': Color(0xFFCDFFDA),
      'image': "assets/images/behind_on_rent_and_bill.png",
    },
    {
      'title': 'Need Food Right Now',
      'color': Color(0xFFFFF0CA),
      'image': "assets/images/need_food_right_now.png",
    },
    {
      'title': 'Medical or Health Emergency',
      'color': Color(0xFFD5EBFF),
      'image': "assets/images/medical_or_health_emergency.png",
    },
    {
      'title': 'Child or Baby Needs',
      'color': Color(0xFFFEDBDF),
      'image': "assets/images/child_or_baby_need.png",
    },
  ];

  FinancialSupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final FinanceController controller = Get.find<FinanceController>();
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Scrollable AppBar + Search
              MyAppBar(
                showNotificationIcon: false,
                showMenuIcon: true,
                showBackIcon: true,
                showBottom: true,
                userName: false,
                screenName: "Financial",
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Manage What You Have',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            AppFonts.secondaryFontFamily, // Use your font
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        GestureDetector(
                          child: Card(
                            elevation: 0,
                            color: Color(0xFFFFF0CA),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/budget.png"),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Budget Planner',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                        Text(
                                          'Plan where your money goes each week. Simple, smart, and free to use.',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed('budget-management');
                          },
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          child: Card(
                            elevation: 0,
                            color: Color(0xFFFEDBDF),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/debet.png"),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Debt Management Checklist',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                        Text(
                                          'Step-by-step guide to help you manage debt and reduce stress.',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed('dabt-management');
                          },
                        ),

                        SizedBox(height: 16),
                        GestureDetector(
                          child: Card(
                            elevation: 0,
                            color: Color(0xFFC8FFE9),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/50-last.png"),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'What: How to Make \$50 Last All Week',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                        Text(
                                          'Quick video with real tips for stretching your budget, no matter your income.',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed('fifty-last-all-week');
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 25),
                        Text(
                          'Official Payment & Support Programs',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                AppFonts.secondaryFontFamily, // Use your font
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Obx(() {
                          final carouselOptions = controller.carouselOptions;
                          return SizedBox(
                            height: 280,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: carouselOptions.length,
                              separatorBuilder:
                                  (context, index) => const SizedBox(width: 16),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                final option = carouselOptions[index];
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: option['backgroundColor'],
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (option['image'] != null)
                                        Image.asset(
                                          option['image'],
                                          height: 40,
                                          color: Colors.black87,
                                        ),
                                      const SizedBox(height: 12),
                                      Text(
                                        option['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        option['description'],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            final url = option['link'];
                                            if (await canLaunchUrl(
                                              Uri.parse(url),
                                            )) {
                                              await launchUrl(
                                                Uri.parse(url),
                                                mode:
                                                    LaunchMode
                                                        .externalApplication,
                                              );
                                            } else {}
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.black87,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                          ),
                                          child: const Text(
                                            'Learn More',
                                            style: TextStyle(
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Text(
                                "Smart Tips For Daily Life",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      AppFonts
                                          .secondaryFontFamily, // Use your font
                                ),
                              ),
                              SizedBox(height: 20),
                              Obx(() {
                                final smartTips = controller.dailyTips;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: smartTips.length,
                                  itemBuilder: (context, index) {
                                    final tips = smartTips[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 5.0,
                                            ), // Adjust this as needed
                                            child: Icon(
                                              Icons.fiber_manual_record,
                                              size: 8.0,
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              tips['tip'].toString(),
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom section with fixed Container and navigation
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
