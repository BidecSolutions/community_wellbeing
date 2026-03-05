import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../main.dart';
class YouthWellbeingController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final RxInt selectedIndex = 0.obs;
  final challenges = <Map<String, dynamic>>[
    {
      'image': 'assets/images/health/walk_outside.png',
      'title': 'Walk Outside for 10 minutes',
      'description': 'Challenge Completed',
      'bgColor': const Color(0xFFE0F7FA),
      'checked': false.obs,
    },
    {
      'image': 'assets/images/health/click_pic.png',
      'title': 'Capture one thing you’re grateful for',
      'description': 'Challenge Completed',
      'bgColor': const Color(0xFFFFF3E0),
      'checked': false.obs,
    },
    {
      'image': 'assets/images/health/no_phone.png',
      'title': ' Try a no-phone hour',
      'description': 'Challenge Completed',
      'bgColor': const Color(0xFFE8F5E9),
      'checked': false.obs,
    },
  ].obs;

  Future<void> fetchYouthWellBegin() async {
    isLoading(true);
    try {
      final url = Uri.parse('${AppSettings.baseUrl}health/youth-wellbeing');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'];

        items.value = data.map<Map<String, dynamic>>((item) {
          return {
            'image': item['image'] ?? '',
            'text': item['heading'] ?? '',
            'description': item['description'] ?? '',
            'bgColor': _parseHexColor(item['bg_color'] ?? '#FFFFFF'),
            'bullets': List<String>.from(item['bullet_points'] ?? []),
          };
        }).toList();

      } else {
        throw Exception('Failed to load');
      }
    }
    catch (e) {
          e;
    }
    finally {
      isLoading(false);
    }
  }

  Color _parseHexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor"; // add alpha
    return Color(int.parse(hexColor, radix: 16));
  }
}




