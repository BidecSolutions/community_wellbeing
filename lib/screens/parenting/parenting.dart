import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../controllers/doctor/find_a_provider_controller.dart';
import '../../controllers/parenting/parenting_support_program_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/location_listener_widget.dart';

class ParentingPage extends StatelessWidget {
  const ParentingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ParentingSupportController controller = Get.put(
      ParentingSupportController(),
    );

    final FindAProviderController doctorController = Get.put(
      FindAProviderController(),
    );

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
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Parenting & Family',
                showBottom: true,
                userName: false,
                showNotificationIcon: true,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                // const SizedBox(height: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //--- parenting support videos start --
                      /* ───── Heading ───── */
                      // --- Talk to someone who understands starts here ---
                      const SizedBox(height: 40),

                      // New section with grids and button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Talk to Someone Who Understands',
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
                                    'Connect privately with trained professionals for personalized parenting guidance, emotional support, or culturally grounded advice',
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
                            const SizedBox(height: 25),

                            // Two half width grids
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD5EBFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/parenting/parenting_coaching.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Parent Coaching Sessions',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'For practical parenting guidance, behavior help, or routines.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontSize: 13,
                                              color: Color(0xFF4C4C4C),
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // doctorController.findDoctors(userLat: pos.latitude, userLon:pos.longitude , radiusKm: doctorController.radius),

                                          // Book Session Button
                                          LocationListenerWidget(
                                            onLocationFetched: (Position pos) {
                                              doctorController.latitude.value =
                                                  pos.latitude;
                                              doctorController.longitude.value =
                                                  pos.longitude;
                                            },
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              // doctorController.findDoctors(
                                              //   userLat:
                                              //       doctorController
                                              //           .latitude
                                              //           .value,
                                              //   userLon:
                                              //       doctorController
                                              //           .longitude
                                              //           .value,
                                              //   radiusKm:
                                              //       doctorController.radius,
                                              // );
                                              Get.toNamed('/find_a_provider');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              'Book Session',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/parenting/support_consults.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Behavioral Support Consults',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Help for parents facing tough child behavior issues.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontSize: 13,
                                              color: Color(0xFF4C4C4C),
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // Book Session Button
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed('/find_a_provider');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              'Book Session',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Full width grid
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF0CA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image on the left
                                  Image.asset(
                                    'assets/images/parenting/matched_mentors.png',
                                    height: 60,
                                    // width: 60,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 12),

                                  // Text content on the right
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Culturally Matched Mentors',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Support from someone who understands your values and background.',
                                          style: TextStyle(
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                            fontSize: 14,
                                            color: Color(0xFF4C4C4C),
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        // Book Session Button
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed('/find_a_provider');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Book Session',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // --- Talk to someone who understands end --

                      // --- parenting support video start --
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Parenting Support Videos ',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /* ───── Custom Grid Layout ───── */
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                              child: Row(
                                children: [
                                  _imageTile(
                                    imagePath:
                                        'assets/images/parenting/workshop.png',
                                    flex: 1,
                                    heading: 'Workshop & Classes',
                                    text:
                                        'Positive parenting, early childhood development.',
                                  ),
                                  const SizedBox(width: 12),
                                  _imageTile(
                                    imagePath:
                                        'assets/images/parenting/one_on_one.png',
                                    flex: 1,
                                    heading: 'One-On-One Support',
                                    text:
                                        'Access to local parenting coaches or family worker.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    controller.fetchVideo(id: 1);
                                    Get.toNamed('/parenting_support_program');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Explore',
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      //--- parenting support videos end --
                      Text(
                        'Whānau Wellbeing Services',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          // mental health start
                          GestureDetector(
                            onTap: () {
                              controller.fetchVideo(id: 2);
                              Get.toNamed('/councelling_therapy');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
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
                                                  'Counseling or therapy (family or couple)',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Support for families or couples to strengthen relationships and emotional wellbeing.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: AppColors.hintColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                            height: 28,
                                            width: 28,
                                            color:
                                                Colors.black, // Apply a color
                                            colorBlendMode: BlendMode.modulate,
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
                          // mental health end
                          // location start
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              controller.fetchVideo(id: 3);
                              Get.toNamed('/conflict_resolution');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
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
                                                  'Conflict Resolution Help',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Guided support to peacefully resolve whānau tensions or disputes.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: AppColors.hintColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                            height: 28,
                                            width: 28,
                                            color:
                                                Colors.black, // Apply a color
                                            colorBlendMode: BlendMode.modulate,
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
                              controller.fetchVideo(id: 4);
                              Get.toNamed('/cultruall_specific');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
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
                                                  'Culturally Specific Whānau Support',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Tailored support grounded in Māori values and community care.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Color(0xFF4C4C4C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/housing/overcrowding_arrow.png', // Replace with your arrow image path
                                            height: 28,
                                            width: 28,
                                            color:
                                                Colors.black, // Apply a color
                                            colorBlendMode: BlendMode.modulate,
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

                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Child Development & Milestones',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /* ───── Custom Grid Layout ───── */
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Row(
                                children: [
                                  _imageTile(
                                    imagePath:
                                        'assets/images/parenting/early_learning.png',
                                    flex: 1,
                                    overlayText: 'Early learning resources',
                                    routeName: '/early_learning_resource',
                                  ),
                                  const SizedBox(width: 12),
                                  _imageTile(
                                    imagePath:
                                        'assets/images/parenting/milestone.png',
                                    flex: 1,
                                    overlayText: 'Milestone checklists',
                                    routeName: '/milestone_checklist',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 2nd row
                      SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Row(
                                children: [
                                  _imageTile(
                                    imagePath:
                                        'assets/images/parenting/health_check.png',
                                    flex: 1,
                                    overlayText:
                                        'Pediatric & health check reminders',
                                    routeName: '/pediatric_health',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //--- Child Development & Milestones end ---

                      // --- Childcare & Early Learning Help here ---
                      const SizedBox(height: 40),

                      // New section with grids and button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Childcare & Early Learning Help',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Two half width grids
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            'Subsidy Eligibility Tools',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Check if your eligible for financial help with childcare',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                              fontSize: 13,
                                              color: Color(0xFF4C4C4C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            'Trusted Early Learning Centers',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Find safe, reliable centers near you',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontSize: 13,
                                              color: Color(0xFF4C4C4C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Full width grid
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFD5EBFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    'School Transition Support',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    ' Get resources to help your child start school with confidence.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/child_care_learning');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Explore',
                                    style: TextStyle(
                                      fontFamily: AppFonts.primaryFontFamily,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- Childcare & Early Learning Help end --

                      //--- Family Emergency Support start --
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Family Emergency Support',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          // house start
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/healthy_homes_application');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD5EBFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/safe_house.png",
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
                                                  'Safe House Access',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                                Text(
                                                  'Confidential support and emergency housing for families facing violence or unsafe situations.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Color(0xFF4C4C4C),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                          // house end
                          // location start
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/helpline_schedule');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEDBDF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/helpline.png",
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
                                                  '24/7 Helplines',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                                Text(
                                                  'Round-the-clock phone or text support for crisis situations like abuse, addiction, or grief.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Color(0xFF4C4C4C),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                              Get.toNamed('/find_a_provider');
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        18,
                                        10,
                                        18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/images/parenting/counseling.png",
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
                                                  'Counseling and Trauma Resources',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppFonts
                                                            .secondaryFontFamily,
                                                  ),
                                                ),
                                                // const SizedBox(height: 4),
                                                Text(
                                                  'Specialized mental health services to help whānau process trauma and recover together.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFonts
                                                            .primaryFontFamily,
                                                    color: Color(0xFF4C4C4C),
                                                  ),
                                                ),
                                              ],
                                            ),
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

                      //--- Family Emergency Support end --
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

  Widget _imageTile({
    required String imagePath,
    required int flex,
    String? overlayText,
    String? heading,
    String? text,
    String? routeName, // ➋ add this
    VoidCallback? onTap,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        // ➍ make the whole tile tappable
        onTap:
            onTap ??
            () {
              if (routeName != null) Get.toNamed(routeName);
            },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (overlayText != null)
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.black.withValues(alpha: 0.1),
                      child: Text(
                        overlayText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFF5F3F3),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (heading != null || text != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (heading != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  if (text != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.hintColor,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
