import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/finance_controller.dart';
import 'request_form.dart';
import '../widgets/drawer.dart';

class ApplyForHelp extends StatelessWidget {
  final FinanceController controller = Get.find<FinanceController>();
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
    {
      'title': 'Grants Support',
      'color': Color(0xFFFFB5FE),
      'image': "assets/images/grant_support.png",
    },
    {
      'title': 'Lost Income or Work Suddenly',
      'color': Color(0xFFC8FFE9),
      'image': "assets/images/lost_income_or_work_suddenly.png",
    },
  ];

  ApplyForHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Apply for Help',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
                profile: true,
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),


              /* ─────────── App-bar End ─────────── */
              // --- Emergency Help & Clinic Access Start--
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ───── Heading ───── */
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Emergency Help',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Not sure what to do in a health emergency? Get quick help, trusted advice, and real-time clinic info.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppFonts.primaryFontFamily,
                              color: Color(0xFF4C4C4C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // New section with grids and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          // Two half width grids 1st
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // call start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final Uri phoneUri = Uri(
                                        scheme: 'tel',
                                        path: '111',
                                      );
                                      if (await canLaunchUrl(phoneUri)) {
                                        await launchUrl(phoneUri);
                                      } else {}
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/call.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Call to 111',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // call end
                                const SizedBox(width: 16),
                                // let someone know start
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate or perform action for the first card
                                      Get.toNamed('/someone_know');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFCDFFDA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/someone_know.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Let Someone Know You’re Okay',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // let someone know end
                              ],
                            ),
                          ),
                          // Two half width grids 1st end
                        ],
                      ),
                    ),
                    // --- Emergency Help & Clinic Access end --
                    //--- financial help start --
                    const SizedBox(height: 40),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Support When You Need It Most',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'If you’re going through a financial emergency, you’re not alone. Here are options to help you cover urgent costs like food, rent, or medical needs.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children:
                          supportOptions.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final Map<String, dynamic> option = entry.value;
                            final int uniqueId = index + 1;
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Use constraints to define the size
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          insetPadding:
                                              EdgeInsets
                                                  .zero, // Remove default padding
                                          contentPadding: EdgeInsets.zero,
                                          clipBehavior: Clip.none,
                                          content: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            width: constraints.maxWidth * 0.9,
                                            height: constraints.maxHeight * 0.6,
                                            child: SingleChildScrollView(
                                              child: RequestForm(uniqueId),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: option['color'],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Image.asset(
                                        option['image'],
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    Positioned(
                                      left: 12,
                                      bottom: 10,
                                      child: SizedBox(
                                        width: 120,
                                        child: Text(
                                          option['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            fontFamily: 'Roboto',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom:
                                          8, // Adjust position for better touch target
                                      right:
                                          8, // Adjust position for better touch target
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return LayoutBuilder(
                                                builder: (
                                                  context,
                                                  constraints,
                                                ) {
                                                  // Use constraints to define the size
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        EdgeInsets
                                                            .zero, // Remove default padding
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    clipBehavior: Clip.none,
                                                    content: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16.0,
                                                          ),
                                                      width:
                                                          constraints.maxWidth *
                                                          0.9,
                                                      height:
                                                          constraints
                                                              .maxHeight *
                                                          0.6,
                                                      child:
                                                          SingleChildScrollView(
                                                            child: RequestForm(
                                                              uniqueId,
                                                            ),
                                                          ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius:
                                              14, // Make the touch target slightly larger
                                          backgroundColor: Colors.white,
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            size: 14,
                                          ), // Slightly larger icon
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),

                    SizedBox(height: 10),
                    //---financial help end --

                    //---Culturally Safe Healthcare start--
                    const SizedBox(height: 40),

                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Help & Protection Resources',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Find trusted support when you need it most — your not alone.',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/request_mentor');
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF0CA),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/applyforhelp/someone_by_your_side.png",
                                    ),
                                  ),

                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Need Someone by Your Side?',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'This isn’t just a help request it’s about...',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppFonts
                                                          .primaryFontFamily,
                                                  color: AppColors.hintColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // bed end
                                ],
                              ),
                            ),
                          ),
                        ),
                        // location end
                        // bed start
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/report_crime');
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD5EBFF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/images/applyforhelp/apply_location.png",
                                    ),
                                  ),

                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Report Crime in your area',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts
                                                          .secondaryFontFamily,
                                                ),
                                              ),
                                              Text(
                                                'Create privacy or extra beds with our supplies',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppFonts
                                                          .primaryFontFamily,
                                                  color: Color(0xFF4C4C4C),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // bed end
                                ],
                              ),
                            ),
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
    );
  }
}
