import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app_settings/settings.dart';
import '../../controllers/profile/profile_controller.dart';
import 'change_image_form.dart';

final box = GetStorage();


class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {

  final ProfileController controller = Get.put(ProfileController());
  @override
    void initState() {
      super.initState();
    }
  @override
  Widget build(BuildContext context) {

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
                screenName: 'Your Profile',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                // const SizedBox(height: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Privacy policy content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // content start here
                                  Center(
                                    child: Column(
                                      children: [
                                        Obx(() {
                                          final localImage = controller.selectedImage.value;
                                          final networkImage = controller.imagePath.value;

                                          if (localImage != null) {
                                            return CircleAvatar(
                                              radius: 50,
                                              backgroundImage: FileImage(localImage),
                                            );
                                          } else if (networkImage.isNotEmpty) {
                                            return CachedNetworkImage(
                                              imageUrl: AppSettings.baseUrl + networkImage,
                                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                                radius: 50,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) => CircleAvatar(
                                                radius: 50,
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/images/user_av.jpg') as ImageProvider,
                                              ),
                                            );
                                          } else {
                                            return CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage('assets/images/user_av.jpg') as ImageProvider,
                                            );
                                          }
                                        }),
                                        const SizedBox(height: 10),
                                        Text(
                                          box.read('name') ?? 'Guest',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            AppFonts.secondaryFontFamily,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Personalize',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                              AppFonts.primaryFontFamily,
                                              color: AppColors.hintColor,
                                            ),
                                          ),
                                        ),
                                        //---card start here --
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          color: Colors.white,
                                          elevation: 0,
                                          child: Column(
                                            children: [
                                              // Row 1 - Personal Info
                                              InkWell(
                                                onTap: () {
                                                  // controller.textbox();
                                                  Get.toNamed('/personal_info');
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.person_3_outlined,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          'Personal Info',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                            AppFonts
                                                                .primaryFontFamily,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Row 2 - Change Password
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                    '/change_password',
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.lock_outline),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          'Change Password',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                            AppFonts
                                                                .primaryFontFamily,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 16,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Row 3 - change image

                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return LayoutBuilder(
                                                        builder: (
                                                            context,
                                                            constraints,
                                                            ) {
                                                          // Use constraints to define the size
                                                          return AlertDialog(
                                                            backgroundColor:
                                                            Colors.white,
                                                            insetPadding:
                                                            EdgeInsets
                                                                .zero, // Remove default padding
                                                            contentPadding:
                                                            EdgeInsets.zero,
                                                            clipBehavior: Clip.none,
                                                            content: Container(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                16.0,
                                                              ),
                                                              width:
                                                              constraints.maxWidth *
                                                                  0.9,
                                                              height:
                                                              constraints
                                                                  .maxHeight *
                                                                  0.4,
                                                              child:
                                                              SingleChildScrollView(
                                                                child: ImageChanger(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.image_rounded,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          'Change Image ',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                            AppFonts
                                                                .primaryFontFamily,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // --- card end here --
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20), // Add some spacing

                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        size: 50.0,
                                        color: Colors.amber,
                                      )
                                          .animate()
                                          .scaleXY(begin: 0.5, end: 1.0, duration: 300.ms)
                                          .then()
                                          .shakeY(),
                                      const SizedBox(height: 15.0),
                                      const Text(
                                        'WARNING',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Text(
                                        'Are You Sure Because it will delete Permanently?',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {

                                              final res = await  controller.deleteMyProfile();
                                              if(res == true){
                                                box.erase();
                                                Get.offAllNamed('/login');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.deepPurpleAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                            ),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                            ),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },

                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red), // Border color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text(
                          'Delete My Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red, // Text color
                            fontFamily: AppFonts.primaryFontFamily,
                          ),
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
    );
  }
}
