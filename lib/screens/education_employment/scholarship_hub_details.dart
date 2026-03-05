import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ScholarshipHubDetails extends StatefulWidget {
  const ScholarshipHubDetails({super.key});

  @override
  State<ScholarshipHubDetails> createState() => _ScholarshipHubDetailsState();
}

class _ScholarshipHubDetailsState extends State<ScholarshipHubDetails> {
  late Map<String, dynamic> scholarShipDetails;

  @override
  void initState() {
    super.initState();
    scholarShipDetails = Get.arguments;
    print("Selected ScholarShip Details: $scholarShipDetails");
  }

  String cleanDescription(String description) {
    String cleaned =
        description
            .replaceAll(RegExp(r'\n\s+'), '\n') // remove indentation
            .trim();

    cleaned = cleaned.replaceFirst(
      RegExp(r'Eligibility Criteria:', caseSensitive: false),
      "<span class='eligibility'>Eligibility Criteria:\n</span>",
    );

    return cleaned;
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
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: '',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    scholarShipDetails['name'] ?? '',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTextField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scholarship Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildText(
                        label: "Provider:",
                        value: scholarShipDetails['provider'] ?? 'N/A',
                      ),
                      buildText(
                        label: "Level:",
                        value: scholarShipDetails['level_name'] ?? 'N/A',
                      ),
                      buildText(
                        label: "Fund:",
                        value: scholarShipDetails['fund_type'] ?? 'N/A',
                      ),
                      buildText(
                        label: "Deadline:",
                        value: scholarShipDetails['dead_line'] ?? 'N/A',
                      ),
                      buildText(
                        label: "Field of Study:",
                        value: scholarShipDetails['study_field'] ?? 'N/A',
                      ),
                      buildText(
                        label: "Duration:",
                        value: scholarShipDetails['duration'] ?? 'N/A',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTextField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Html(
                    data: cleanDescription(
                      scholarShipDetails['description'] ?? '',
                    ),
                    style: {
                      "body": Style(
                        fontSize: FontSize(14),
                        whiteSpace: WhiteSpace.pre,
                        color: AppColors.accentColor,
                      ),
                      ".eligibility": Style(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(16),
                        margin: Margins.only(bottom: 5),
                      ),
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/scholarshipForm');
                    },
                    child: Text(
                      "Continue to Application",
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
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

Widget buildText({
  required String label,
  required String value,
  double labelWidth = 100, // adjust width as needed
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: labelWidth,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}
