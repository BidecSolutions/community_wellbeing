import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';

class SocialSupportController extends GetxController {
  var isLoading = false.obs;
  var message = "".obs;

  var mainHeading = "".obs;
  var subHeading = "".obs;
  var youtubeVideoUrl = "".obs;
  var videoDescription = "".obs;

  RxList<Map<String, dynamic>> navigators = <Map<String, dynamic>>[].obs;


  Future<void> fetchMainPage() async {
    try {
      final url = Uri.parse('${AppSettings.baseUrl}social/landing-page');
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
        );
        if (response.statusCode == 200) {
          final apiResponse = jsonDecode(response.body);
          final data = apiResponse['data'];
          mainHeading.value = data['main_heading'];
          subHeading.value = data['sub_heading'];
          youtubeVideoUrl.value = data['video_link'];
          videoDescription.value = data['video_description'];
        }
   }
   catch (e) {
      message.value = 'Request Not Sent: $e';
    }
  }

  Future<void> fetchNavigator() async {
    try {
      final url = Uri.parse('${AppSettings.baseUrl}social/get-community-navigator');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );

      if (response.statusCode == 200) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];

        if (data is List) {
          navigators.value = data.map<Map<String, dynamic>>((item) {
            return {
              "id": item['id'],
              "name": item['name'],
              "image": item['navigator_image'],
              "location": item['location'],
              "contact": item['contact_number'],
            };
          }).toList();
        }
      } else {
        message.value = 'Failed with status: ${response.statusCode}';
      }
    } catch (e) {
      message.value = 'Request Not Sent: $e';
    }
  }

  final programs = <Map<String, dynamic>>[
    {
      "id": "1",
      "name": "Elderly Check-Ins Support",
      "icon": "assets/images/social/elder_support.png",
      "color": "FFF0CA",
    },
    {
      "id": "2",
      "name": "Meal or food parcel delivery",
      "icon": "assets/images/social/meal_food.png",
      "color": "FFD5EBFF",
    },
    {
      "id": "3",
      "name": "Help with phones / tech",
      "icon": "assets/images/social/help_with_phone.png",
      "color": "CDFFDA",
    },
    {
      "id": "4",
      "name": "Winter gear donation",
      "icon": "assets/images/social/winter_gear.png",
      "color": "FEDBDF",
    },
  ].obs;





  Color parseHexColor(String hexColor) {
    try {
      hexColor = hexColor.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor"; // add opacity
      }
      return Color(int.parse("0x$hexColor"));
    } catch (_) {
      return Colors.grey.shade300;
    }
  }

}
