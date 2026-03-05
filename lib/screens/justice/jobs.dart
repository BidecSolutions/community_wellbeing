import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/justice/job_controller.dart';
import 'package:community_app/screens/justice/custom_bottom_sheet.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Jobs extends StatelessWidget {
  Jobs({super.key});

  final JobController jobController = Get.put(JobController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        jobController.loadMoreJobs();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (jobController.jobs.isEmpty) {
        jobController.fetchJobs();
      }
    });

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Jobs',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    height: 38,
                    width: 52,
                    decoration: BoxDecoration(
                      color: AppColors.whiteTextField,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.tune, size: 20),
                  ),
                  const SizedBox(width: 6),

                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: OutlinedButton(
                        onPressed:
                            () => showCategoryBottomSheet(
                              context,
                              Get.find<JobController>(),
                            ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ), // 15px border
                          ),
                          side: BorderSide(color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Obx(() {
                          final selected = jobController.selectedCategory.value;
                          return Text(
                            selected != null
                                ? selected['name']
                                : "Select Category",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // SA2 BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: OutlinedButton(
                        onPressed:
                            () => showSA2BottomSheet(
                              context,
                              Get.find<JobController>(),
                            ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ), // 15px border
                          ),
                          side: BorderSide(color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Obx(() {
                          final selected = jobController.selectedSA2.value;
                          return Text(
                            selected != null
                                ? selected['name']
                                : "Select SA2 Area",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final jobs = jobController.jobs;
                  final isLoading = jobController.isLoading.value;
                  final isLoadingMore = jobController.isLoadingMore.value;

                  if (isLoading && jobs.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: jobs.length + (isLoadingMore ? 1 : 0),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteTextField,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ListTile(
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
                                titleAlignment: ListTileTitleAlignment.top,
                                contentPadding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 3,
                                  left: 10,
                                  right: 10,
                                ),
                                leading: Image.network(
                                  job.companyLogo,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, _, _) => Image.network(
                                        'https://media.licdn.com/dms/image/v2/D4D0BAQEzPN7hxA7bmg/company-logo_200_200/B4DZXADAtUHkAM-/0/1742683770213/bidec_solutions_pvt_ltd_logo?e=2147483647&v=beta&t=ZKe4MoXpLEfpuN0c2Oh-7OPDTaXfwfoY-pQsJCf_vxQ',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                                title: Text(
                                  job.jobTitle,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: AppFonts.secondaryFontFamily,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    const SizedBox(height: 2),
                                    _buildRichText(
                                      'Experience Level: ',
                                      jobController.getExperienceLevelText(
                                        job.experienceLevel,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    _buildRichText(
                                      'Job type: ',
                                      jobController.getJobTypeText(job.jobType),
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                top: 8,
                                right: 14,
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
                                  top: 8,
                                  right: 55,
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
                        ),
                      );
                    },
                  );
                }),
              ),

              SizedBox(height: 5),
            ],
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

void showCategoryBottomSheet(
  BuildContext context,
  JobController jobController,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredCategories =
      jobController.uniqueCategories.obs;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Search Jobs",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    final filtered =
                        jobController.uniqueCategories
                            .where(
                              (element) => element['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(query.toLowerCase()),
                            )
                            .toList();
                    filteredCategories.value = filtered;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final item = filteredCategories[index];
                      return ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        title: Text(item['name']),
                        trailing: Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          jobController.selectedCategory.value = item;
                          jobController.filterJobsByCategory();
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSA2BottomSheet(BuildContext context, JobController jobController) {
  if (jobController.selectedCategory.value == null) {
    Get.snackbar(
      "No Category Selected",
      "Please select a category first.",
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  jobController.loadSA2ForSelectedCategory();

  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredSA2 = jobController.sa2List;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Search SA2 Area",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: searchController,
              onChanged: (query) {
                final filtered =
                    jobController.sa2List
                        .where(
                          (element) => element['name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()),
                        )
                        .toList();
                filteredSA2.value = filtered;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Type to search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: filteredSA2.length,
                itemBuilder: (context, index) {
                  final item = filteredSA2[index];
                  return ListTile(
                    leading: Icon(Icons.place_outlined),
                    title: Text(item['name']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      jobController.selectedSA2.value = item;
                      jobController.loadSA2ForSelectedCategory();
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
