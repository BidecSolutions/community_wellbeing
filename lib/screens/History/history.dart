import 'dart:developer';

import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/History/app_categories_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityAndHistory extends StatefulWidget {
  const ActivityAndHistory({super.key});

  @override
  State<ActivityAndHistory> createState() => _ActivityAndHistoryState();
}

class _ActivityAndHistoryState extends State<ActivityAndHistory> {
  final controller = Get.put(AppCategoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              showNotificationIcon: true,
              showMenuIcon: true,
              showBackIcon: true,
              showBottom: false,
              userName: false,
              screenName: "My Activity & Requests",
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 20.0,
                right: 10.0,
                bottom: 10.0,
              ),
              child: Obx(() {
                return Wrap(
                  spacing: 16,
                  runSpacing: 20,
                  children:
                      controller.categories.map((category) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              '/history_form',
                              arguments: {'cateID': category.id, 'cateName': category.moduleName },
                            );
                            log('request id: ${category.id}');
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 4 - 25,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    AppSettings.baseUrl + category.icon,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.moduleName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
