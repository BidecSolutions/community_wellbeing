import 'package:community_app/controllers/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_settings/colors.dart';
import '../widgets/snack_bar.dart';




class ImageChanger extends StatefulWidget {
  const ImageChanger({super.key});

  @override
  State<ImageChanger> createState() => _ImageChangerState();
}

class _ImageChangerState extends State<ImageChanger> {
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Label
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Profile Image',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),

        // Upload container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            return InkWell(
              onTap: () => controller.pickImageFile(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.whiteTextField,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_rounded,
                      size: 40,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      controller.imageFilePath.value.isEmpty
                          ? 'Tap to Upload Image'
                          : 'Uploaded: ${controller.imageFilePath.value.split('/').last}',
                      style: TextStyle(
                        fontSize: 14,
                        color: controller.imageFilePath.value.isEmpty
                            ? Colors.grey
                            : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 24),

        // Submit button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await controller.changeProfileImage();
                if (result == true) {
                  final snackBarShow = Snackbar(
                    title: 'Success',
                    message: controller.message.value.toString(),
                    type: 'success',
                  );
                  snackBarShow.show();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } else {
                  final snackBarShow = Snackbar(
                    title: 'Error',
                    message: controller.message.value.toString(),
                    type: 'error',
                  );
                  snackBarShow.show();
                }
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Change Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );


  }
}