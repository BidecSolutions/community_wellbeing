import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controllers/profile/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
final box = GetStorage();

class PersonalInfo extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  PersonalInfo({super.key});

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
                screenName: 'Your Profile Info',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(), // Pushes center content to center

                        // Avatar and Name
                        Column(
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
                              // getLastName(loginUser),
                              box.read('name') ?? 'Guest',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: AppFonts.secondaryFontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Edit icon aligned to top
                        const Spacer(), // Pushes icon to the right
                        Align(
                          alignment: Alignment.topRight,
                          child:  IconButton(
                            icon: Icon(Icons.edit_square),
                            onPressed: () => _showImagePickerModal(context, controller),
                          ),
                        ),
                      ],
                    ),
                    //--- form start ---
                    // -- your Name start --
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),

                          // Full-width name text field
                          Obx(
                                () => TextField(
                              controller: controller.nameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // No leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                hintStyle:  TextStyle(
                                  fontSize: 12,         // Adjust font size as needed
                                  color: AppColors.hintColor,   // Adjust hint color
                                ),
                                errorText: controller.nameError.value.isEmpty
                                    ? ' ' // Single space reserves height without showing text
                                    : controller.nameError.value,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          // name end
                          const SizedBox(height: 3),

                          // Full-width name text field
                          Obx(
                                () => TextField(
                              controller: controller.addressController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s'),
                                ), // No leading space
                              ],
                              decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle:  TextStyle(
                                  fontSize: 12,         // Adjust font size as needed
                                  color: AppColors.hintColor,   // Adjust hint color
                                ),
                                errorText: controller.addressError.value.isEmpty
                                    ? ' ' // Single space reserves height without showing text
                                    : controller.addressError.value,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteTextField,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          // name end
                          const SizedBox(height: 3),

                          // email anda phone start
                           Row(
                            children: [
                              // email TextField
                              Expanded(
                                child: Column(
                                  children: [
                                    Obx(
                                          () => TextField(
                                        controller: controller.emailController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                            RegExp(r'^\s'),
                                          ), // No leading space
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle:  TextStyle(
                                            fontSize: 12,         // Adjust font size as needed
                                            color: AppColors.hintColor,   // Adjust hint color
                                          ),
                                          errorText: controller.emailError.value.isEmpty
                                              ? ' ' // Single space reserves height without showing text
                                              : controller.emailError.value,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteTextField,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Phone TextField
                              Expanded(
                                child: Column(
                                  children: [
                                    Obx(
                                          () => TextField(
                                        controller: controller.phoneController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Only numbers
                                          FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'),
                                          ), // No spaces
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Phone No',
                                          hintStyle:  TextStyle(
                                            fontSize: 12,         // Adjust font size as needed
                                            color: AppColors.hintColor,   // Adjust hint color
                                          ),
                                          errorText: controller.phoneError.value.isEmpty
                                              ? ' ' // Single space reserves height without showing text
                                              : controller.phoneError.value,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteTextField,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // email and phone end
                          const SizedBox(height: 3),

                          // dob and hni start
                          Row(
                            children: [
                              // email TextField
                              Expanded(
                                child: Column(
                                  children: [
                                    Obx(
                                          () => TextField(
                                        controller: controller.dobController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                            RegExp(r'^\s'),
                                          ), // No leading space
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Date Of Birth',
                                          hintStyle:  TextStyle(
                                            fontSize: 12,         // Adjust font size as needed
                                            color: AppColors.hintColor,   // Adjust hint color
                                          ),
                                          errorText: controller.dobError.value.isEmpty
                                              ? ' ' // Single space reserves height without showing text
                                              : controller.dobError.value,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteTextField,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Phone TextField
                              Expanded(
                                child: Column(
                                  children: [
                                    Obx(
                                          () => TextField(
                                        controller: controller.hniController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Only numbers
                                          FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'),
                                          ), // No spaces
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Your NHI',
                                          hintStyle:  TextStyle(
                                            fontSize: 12,         // Adjust font size as needed
                                            color: AppColors.hintColor,   // Adjust hint color
                                          ),
                                          errorText: controller.hniError.value.isEmpty
                                              ? ' ' // Single space reserves height without showing text
                                              : controller.hniError.value,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteTextField,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // dob and hni end
                        ],
                      ),
                    ),


                    // ───── Submit Button ─────
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.updateUserProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.primaryFontFamily,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //--- form end ---
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
  void _showImagePickerModal(BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SizedBox(
          height: 160,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () async {
                  // Request permission to access photos
                  PermissionStatus mediaStatus = await Permission.photos.request();
                  if (mediaStatus.isGranted) {
                    controller.pickImage(source: ImageSource.gallery); // Open gallery
                  } else {
                    Get.snackbar("Permission Denied", "Please grant permission to access media.");
                  }
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () async {
                  // Request permission to access camera
                  PermissionStatus cameraStatus = await Permission.camera.request();
                  if (cameraStatus.isGranted) {
                    controller.pickImage(source: ImageSource.camera); // Open camera
                  } else {
                    Get.snackbar("Permission Denied", "Please grant permission to access camera.");
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }

                },
              ),
            ],
          ),
        );
      },
    );
  }


}
