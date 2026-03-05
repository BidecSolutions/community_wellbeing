import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:community_app/app_settings/fonts.dart';


class WhatAroundMeSection extends StatelessWidget {
  final List<Map<String, String>> gridItems;
  final String title;

  const WhatAroundMeSection({super.key, required this.gridItems, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 20.0, top: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.secondaryFontFamily, // Use your font

            ),
            textAlign: TextAlign.left,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.0, // Adjust as needed
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return GestureDetector(
              onTap: () async {
                final url = Uri.parse(item['link'] ?? 'https://www.example.com');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  Get.snackbar(
                    'Error',
                    'Could not launch URL',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack( // Use Stack to overlay text on the image
                  fit: StackFit.expand, // Make Stack fill the Card
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset( // Use Image.asset
                        item['imagePath'] ?? 'assets/images/placeholder.png', // Fallback
                        fit: BoxFit.cover, // Image covers the entire Card
                      ),
                    ),
                    // Positioned widget to place the label at the bottom
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          // Add a semi-transparent black background for better readability
                          // color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Text(
                          item['label'] ?? 'No Label',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // White text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

