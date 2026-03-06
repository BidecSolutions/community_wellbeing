import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/justice/job_controller.dart';
import 'package:community_app/screens/justice/custom_bottom_sheet.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/seminar_and_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisabilitySupport extends StatelessWidget {
  DisabilitySupport({super.key});
  final JobController jobController = Get.put(JobController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: false,
                  showBackIcon: true,
                  screenName: 'Disability Support Hub',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey,
                  thickness: 1,      // height of the line
                  indent: 20,        // left space
                  endIndent: 20,     // right space
                ),

                const SizedBox(height: 60),
                Text(
                  "Disability Resource Center",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Information, Guides, And Rights, Everything You Need To Know.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),

                // Card Section
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/articles');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/images/disability/disabilityFront.png",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Text Section
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Featured Guides & Articles",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Find A Local Tutor Or Kaiārahi (Mentor) For Support In Maths, Reading, Writing Or Any Subject.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Inclusive Events Section
                Text(
                  "Inclusive Events & Activities",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Information, Guides, And Rights, Everything\nYou Need To Know.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(child: SeminarAndEvents(category: [1], title: false)),
                const SizedBox(height: 60),
                const Text(
                  "Check In & Let Them Know",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Share A Quick Message And Your Location\nWith Those Who Care.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),

                // Green Box
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/someone_know');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDFFDA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/health/someone_know.png",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Let Someone Know You're Okay",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Section 2: Jobs
                const Text(
                  "Jobs You Can Apply For Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore Local Job Opportunities And Take The First Step Toward Your Career.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
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
                  "Request Support from Your Community",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Post a request for help and connect with those who care.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),

                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/request_support_form');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Colored Icon Container
                        Container(
                          height: 80,
                          width: 60,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F0FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/health/care_option.png',
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Text Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Submit your Request',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Post a request for help and connect with those who care.',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
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
