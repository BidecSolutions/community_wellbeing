import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/justice/job_controller.dart';
import 'package:community_app/screens/justice/job_apply_foam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String company;
  final String imagePath;
  final String jobType;
  final String posted;
  final String experience;
  final int clicks;
  final String details;
  final int jobId;
  final int index;
  final bool applied;

  CustomBottomSheet({
    super.key,
    required this.title,
    required this.company,
    required this.imagePath,
    required this.jobType,
    required this.posted,
    required this.details,
    required this.experience,
    required this.clicks,
    required this.jobId,
    required this.index,
    required this.applied,
  });

  final JobController jobController = Get.put(JobController());
  final text =
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 40,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon at the top center
                Row(
                  children: [
                    Image.network(
                      imagePath,
                      width: 60,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Image.network(
                            'https://media.licdn.com/dms/image/v2/D4D0BAQEzPN7hxA7bmg/company-logo_200_200/B4DZXADAtUHkAM-/0/1742683770213/bidec_solutions_pvt_ltd_logo?e=2147483647&v=beta&t=ZKe4MoXpLEfpuN0c2Oh-7OPDTaXfwfoY-pQsJCf_vxQ',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
                Text(
                  jobController.jobs[index].applied == 1
                      ? 'Job posted $posted ago. You have applied for the job.'
                      : 'Job posted $posted ago. Apply for job by submitting the form.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.accentColor,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Obx(() {
                      if (jobController.jobs[index].applied == 1) {
                        return Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.check,
                            color: AppColors.backgroundColor,
                            size: 14,
                          ),
                        );
                      } else if (clicks == 1) {
                        return Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.visibility_outlined,
                            color: AppColors.backgroundColor,
                            size: 14,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.hintColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        jobType,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.hintColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        experience,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  'About the Job',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Job Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                SizedBox(height: 10),
                ReadMoreText(
                  details,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  trimMode: TrimMode.Line,
                  moreStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                  ),
                  trimLines: 5,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      bool isApplied = jobController.jobs[index].applied == 1;
                      return ElevatedButton.icon(
                        onPressed:
                            isApplied
                                ? null
                                : () async {
                                  final result = await Get.to(
                                    () => const ApplyForJob(),
                                      arguments: jobId,
                                  );

                                  if (result != null &&
                                      result is Map &&
                                      result['applied'] == true) {
                                    jobController.jobs[index].applied = 1;
                                    jobController.jobs.refresh();
                                  }
                                },
                        icon: Icon(
                          Icons.open_in_new,
                          size: 18,
                          color: Colors.white,
                        ), // External link icon
                        label: Text(
                          "Apply",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primaryColor, // LinkedIn Blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ), // pill shape
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 5,
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text("Close"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -30, // Half outside
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/3281/3281289.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
