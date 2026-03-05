import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/education/ready_for_license_controller.dart';
import 'package:community_app/controllers/justice/job_controller.dart';
import 'package:community_app/screens/education_employment/license_quiz_start.dart';
import 'package:community_app/screens/education_employment/ready_for_license.dart';
import 'package:community_app/screens/justice/custom_bottom_sheet.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Education extends StatefulWidget {
  Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final JobController jobController = Get.put(JobController());

  final controller = Get.put(ReadyForLicenseController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.fetchPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // * ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: ' Education & Employment',
                  showBottom: true,
                  userName: false,
                  showNotificationIcon: true,
                ),
                const SizedBox(height: 40),

                /// 🖥 Main Heading
                const Text(
                  'Learning Support for Tamariki & Rangatahi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                /// 📝 Subheading
                const Text(
                  'Culturally safe help, wherever you are — free and community-led.',
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
                    Get.toNamed('/learningModule');
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
                            'assets/images/education/Mask group.png',
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
                const SizedBox(height: 60),
                const Text(
                  'Get Ready for Your First Job',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                /// 📝 Subheading
                const Text(
                  'Career support for rangatahi and solo parents – from CVs to job interviews.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/coaches');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF0CA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/education/Mask group (1).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  '1:1 Career Coaching',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
                      // not sure start
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/interviewConfidence');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFD5EBFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/education/Mask group (2).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Mock Interview Videos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // not sure end
                    ],
                  ),
                ),
                // Two half width grids 1st end
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // call start
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Get.toNamed('/resumeTemplate');
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
                                  'assets/images/education/Mask group (3).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'CV / Resume Templates',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
                      // not sure start
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/firstJobKit');
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
                                  'assets/images/education/Mask group (4).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'My First Job',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // not sure end
                    ],
                  ),
                ),

                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/appliances_repair');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/images/education/car.png',
                          width: double.infinity,
                          height: 200,
                          // fit: BoxFit.,
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            top: 45,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              // SizedBox(height: 20),
                              Text(
                                'Get Your Driver Licence - Step by Step',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.secondaryFontFamily,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Build confidence with free mock tests, helpful tips, and step-by-step support — all tailored for your journey.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  height: 1.5,
                                  fontFamily: AppFonts.primaryFontFamily,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => LicenseQuizStart())!.then((_) {
                                    controller.fetchPoints();
                                  });
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                ),
                                child: Text(
                                  'Start Practice Test',
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
                ),

                const SizedBox(height: 60),
                const Text(
                  'Jobs You Can Apply for Now',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                /// 📝 Subheading
                const Text(
                  'Explore local job opportunities and take the first step toward your career.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Obx(() {
                    final jobs = jobController.jobs;
                    final isLoading = jobController.isLoading.value;
                    // final isLoadingMore = jobController.isLoadingMore.value;

                    if (isLoading && jobs.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobs.length > 3 ? 3 : jobs.length,
                      itemBuilder: (context, index) {
                        // Loader at the bottom
                        if (index >= jobs.length) {
                          return const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final job = jobs[index];
                        final formattedPostedDate = jobController.formatTimeAgo(
                          job.jobPostedDate,
                        );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  jobController.applyForJob(
                                    type: 'view',
                                    jobID: job.jobId,
                                  );
                                  job.viewed = 1;
                                  jobController.jobs[index] = job;
                                  jobController.jobs.refresh();

                                  Get.bottomSheet(
                                    CustomBottomSheet(
                                      title: job.jobTitle,
                                      company: job.companyName,
                                      imagePath: job.companyLogo,
                                      jobType: jobController.getJobTypeText(
                                        job.jobType,
                                      ),
                                      posted: formattedPostedDate,
                                      experience: jobController
                                          .getExperienceLevelText(
                                            job.experienceLevel,
                                          ),
                                      clicks: job.viewed,
                                      details: job.details,
                                      jobId: job.jobId,
                                      index: index,
                                      applied: job.applied == 1,
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Company Logo
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          job.companyLogo,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,

                                          errorBuilder:
                                              (_, _, _) => Image.network(
                                                'https://media.licdn.com/dms/image/v2/D4D0BAQEzPN7hxA7bmg/company-logo_200_200/B4DZXADAtUHkAM-/0/1742683770213/bidec_solutions_pvt_ltd_logo?e=2147483647&v=beta&t=ZKe4MoXpLEfpuN0c2Oh-7OPDTaXfwfoY-pQsJCf_vxQ',
                                                width: 55,
                                                height: 55,
                                                fit: BoxFit.cover,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),

                                      // Job Details
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            job.jobTitle,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            job.companyName,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.accentColor,
                                              fontFamily:
                                                  AppFonts.secondaryFontFamily,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          _buildRichText(
                                            'Experience Level: ',
                                            jobController
                                                .getExperienceLevelText(
                                                  job.experienceLevel,
                                                ),
                                          ),
                                          const SizedBox(height: 2),
                                          _buildRichText(
                                            'Job Type: ',
                                            jobController.getJobTypeText(
                                              job.jobType,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 170,
                                right: 25,
                                child: Text(
                                  formattedPostedDate,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                              ),
                              if (jobController.jobVisibility(job.viewed))
                                Positioned(
                                  top: 15,
                                  right: 25,
                                  child: Container(
                                    height: 13,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.visibility_outlined,
                                      color: AppColors.backgroundColor,
                                      size: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/jobs');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),

                  child: Text("View All"),
                ),
                const SizedBox(height: 60),
                const Text(
                  'Find Your Path Back to Learning',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // call start
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.toNamed('/browsePlaylist'),
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFFEDBDF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/education/Mask group (5).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Self Learning',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
                      // not sure start
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/coaches');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 183, 249, 201),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/education/Mask group (6).png',
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Whānau Learning Coaches',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFonts.secondaryFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // not sure end
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  'Your Path to Further Learning Starts Here',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                /// 📝 Subheading
                const Text(
                  'Support, guidance, and stories to help you take the next step with confidence.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
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
                                  'assets/images/education/image (4).png',
                              flex: 1,
                              overlayText: 'Your Scholarship Hub',
                              routeName: '/scholarshipHub',
                            ),
                            const SizedBox(width: 12),
                            _imageTile(
                              imagePath:
                                  'assets/images/education/image (3).png',
                              flex: 1,
                              overlayText: 'Real Stories That Inspire',
                              routeName: '/realStories',
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
                                  'assets/images/education/image (5).png',
                              flex: 1,
                              overlayText: 'Upcoming Intakes & Events',
                              routeName: '/upcomingOpportunities',
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
        ),
      ),
    );
  }
}

Widget _buildRichText(String label, String value) {
  return RichText(
    text: TextSpan(
      text: label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.secondaryFontFamily,
        color: AppColors.textColor,
      ),
      children: [
        TextSpan(
          text: value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.accentColor,
          ),
        ),
      ],
    ),
  );
}

Widget _imageTile({
  required String imagePath,
  required int flex,
  String? overlayText,
  String? heading,
  String? text,
  String? routeName,
  VoidCallback? onTap,
}) {
  return Expanded(
    flex: flex,
    child: GestureDetector(
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
                  left: 5,
                  right: 5,
                  bottom: 15,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.black.withValues(alpha: 0.1),
                    child: Text(
                      overlayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
