import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/emergency_housing/shelter_detail_controller.dart';
import '../../controllers/emergency_housing/shelter_request_controller.dart';
import '../widgets/drawer.dart';


class ShelterDetail extends StatelessWidget {
  ShelterDetail({super.key});
  final controller = Get.put(ShelterDetailController());
  final controller1 = Get.put(ShelterRequestController());

  @override
  Widget build(BuildContext context) {
    final shelterData = Get.arguments as Map<String, dynamic>;

    final List<dynamic> galleryImages = json.decode(shelterData['gallery']);
    final image = shelterData['cover_image'];
    final label = shelterData['name'];
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
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Shelter Detail',
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


              Padding(

                padding: const EdgeInsets.all(20.0),

                child:Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: image == null ? Colors.blue : null,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image != null
                        ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(AppSettings.baseUrl +image, fit: BoxFit.cover),
                        if (label != null)
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                label,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    )
                        : const SizedBox.expand(),
                  ),
                )




              ),

              // --- end of slider --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title
                    Text(
                      shelterData['name'] as String? ?? '',
                      style: const TextStyle(

                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bed, size: 16, color: AppColors.primaryColor),
                            const SizedBox(width: 6),
                            const Text(
                              'Beds Available:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text( shelterData['capacity'] as String?  ?? '',
                              maxLines: 2, // Allows wrapping to 2 lines
                              overflow: TextOverflow.visible, // Optional: allows full text to wrap
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(Icons.location_on, size: 18, color: AppColors.primaryColor),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Address: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: shelterData['address'] as String? ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      shelterData['des'] as String?  ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: AppFonts.primaryFontFamily,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Gallery
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      height: 80,
                      child: ListView.separated(

                        scrollDirection: Axis.horizontal,
                        itemCount: galleryImages.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {

                          final imgPath = AppSettings.baseUrl+galleryImages[index];
                          return GestureDetector(
                            onTap: () {
                              // Open full screen image view
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        imgPath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imgPath,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        // Request Submit Button (Primary Color)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller1.fillData(id: shelterData['id']);
                              Get.toNamed('/shelter_request');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Request Submit',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Call Now Button (Border Only)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              final contact = shelterData['contact'] as String? ?? '';
                              if (contact.isNotEmpty) {
                                final Uri phoneUri = Uri(scheme: 'tel', path: contact);
                                if (await canLaunchUrl(phoneUri)) {
                                  await launchUrl(phoneUri);
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Call Now',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
