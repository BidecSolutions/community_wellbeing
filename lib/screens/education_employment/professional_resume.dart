import 'dart:developer';
import 'dart:io';

import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/resume_template_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ProfessionalResume extends StatefulWidget {
  const ProfessionalResume({super.key});

  @override
  State<ProfessionalResume> createState() => _ProfessionalResumeState();
}

class _ProfessionalResumeState extends State<ProfessionalResume> {
  late Map<String, dynamic> selectedTemplate;
  final controller = Get.put(ResumeTemplateController());
  @override
  void initState() {
    super.initState();
    selectedTemplate = Get.arguments;
    print("Selected Template: $selectedTemplate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Professional Resume',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                Center(
                  child: Text(
                    'Professional look for corporate or admin roles.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 300,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFF9F9F9),
                          const Color(0xFFC3C3C3),
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        Uri.parse(
                          "${AppSettings.baseUrl}${selectedTemplate['cover_image']}",
                        ).toString(),
                        height: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    selectedTemplate['title'] ?? 'No title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Table(
                    columnWidths: const {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: const [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                            ), // 👈 reduced
                            child: Text(
                              "Format",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 4,
                            ), // 👈 reduced
                            child: Text(
                              "PDF, DOCX, Google Docs",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "Best For",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 4,
                            ),
                            child: Text(
                              "Office Jobs, Trade Roles, Internships",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "Design Style",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 4,
                            ),
                            child: Text(
                              "Minimalist, Professional, Creative, Modern",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "Language Options",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 4,
                            ),
                            child: Text(
                              "English, Te Reo Māori, Bilingual",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final filePath = selectedTemplate['download_link'];

                      controller.downloadResume(filePath);
                    },
                    child: const Text(
                      "Download Template",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
