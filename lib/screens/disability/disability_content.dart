import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/disability/disability_content_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class DisabilityContent extends StatelessWidget {
  final controller = Get.find<DisabilityContentController>();
  DisabilityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = AppSettings.baseUrl;
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: controller.articleDetails['name'].toString(),
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network("$imagePath${controller.articleDetails['image'] ?? ''}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

               Padding(
                padding: const EdgeInsets.all(16),
                  child:  Html(
                    data: controller.articleDetails['article_content']?.toString() ?? "",
                    style: {
                      "h1": Style(fontSize: FontSize(28), fontWeight: FontWeight.bold),
                      "h2": Style(fontSize: FontSize(24), fontWeight: FontWeight.bold),
                      "h3": Style(fontSize: FontSize(20), fontWeight: FontWeight.w600),
                      "h4": Style(fontSize: FontSize(18), fontWeight: FontWeight.w600),
                      "h5": Style(fontSize: FontSize(16), fontWeight: FontWeight.w600),
                      "h6": Style(fontSize: FontSize(14), fontWeight: FontWeight.w600),
                      "p": Style(fontSize: FontSize(14), lineHeight: LineHeight(1.5)),
                      "b": Style(fontWeight: FontWeight.bold),
                      "strong": Style(fontWeight: FontWeight.bold),
                      "i": Style(fontStyle: FontStyle.italic),
                      "em": Style(fontStyle: FontStyle.italic),
                      "ul": Style(margin: Margins.symmetric(vertical: 10)),
                      "ol": Style(margin: Margins.symmetric(vertical: 10)),
                      "li": Style(fontSize: FontSize(16)),
                      "a": Style(
                        color: Colors.blue,
                        textDecoration: TextDecoration.underline,
                      ),
                    },
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
