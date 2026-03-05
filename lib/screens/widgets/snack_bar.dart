import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar extends StatelessWidget {
  final String title;
  final String message;
  final String type;
  final Duration duration;

  const Snackbar({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.duration = const Duration(seconds: 3),
  });

  void show() {
    IconData typeIcon = Icons.info_outline; // Default icon
    Color typeColor = Colors.grey.shade700; // Default color

    if (type == 'error') {
      typeIcon = Icons.error_outline;
      typeColor = Colors.redAccent;
    } else if (type == 'success') {
      typeIcon = Icons.check_circle;
      typeColor = Colors.green;
    } else if (type == 'warning') {
      typeIcon = Icons.warning_amber_outlined;
      typeColor = Colors.orangeAccent;
    }

    Get.rawSnackbar(
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      messageText: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: typeColor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: duration,
      icon: Icon(typeIcon, color: Colors.white, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
