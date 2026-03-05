
import 'package:get/get.dart';
class JusticeSafetyController extends GetxController {
  var providerCards =
      [
        {
          "name": "Mereana Rangi",
          "rows": [
            {
              "label1": "Te Mana Clinic",
              "image2": "assets/images/health/locationpin.png",
              "label2": "Māngere East, Auckland",
            },
            {
              "image1": "assets/images/health/clock.png",
              "label1": "8:00 AM – 8:00 PM",
              "image2": "assets/images/health/phone.png",
              "label2": "09 888 3322",
            },
            {
              "image1": "assets/images/health/checked.png",
              "label1": "Māori-led",
              "image2": "assets/images/health/leaf.png",
              "label2": "Rongoā-friendly",
            },
          ],
        },
        // ── Add more provider maps here ──
        {
          "name": "Mereana Rangi",
          "rows": [
            {
              "label1": "Te Mana Clinic",
              "image2": "assets/images/health/locationpin.png",
              "label2": "Māngere East, Auckland",
            },
            {
              "image1": "assets/images/health/clock.png",
              "label1": "8:00 AM – 8:00 PM",
              "image2": "assets/images/health/phone.png",
              "label2": "09 888 3322",
            },
            {
              "image1": "assets/images/health/checked.png",
              "label1": "Māori-led",
              "image2": "assets/images/health/leaf.png",
              "label2": "Rongoā-friendly",
            },
          ],
        },
      ].obs;

  //horizontal scroll start
  final supportItems =
      [
        {
          'image': 'assets/images/justice/fire_safety_image.png',
          'title': 'Mental Health Support',
          'date': '18 July 2025',
          'time': '10:00 AM - 02:00 PM',
        },
        {
          'image': 'assets/images/justice/fire_safety_image.png',
          'title': 'Family Counseling',
          'date': '20 July 2025',
          'time': '12:00 PM - 03:00 PM',
        },
        {
          'image': 'assets/images/justice/fire_safety_image.png',
          'title': 'Nutrition Guidance',
          'date': '22 July 2025',
          'time': '09:00 AM - 01:00 PM',
        },
      ].obs;


}
