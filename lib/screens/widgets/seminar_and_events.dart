import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/fonts.dart';
import '../../app_settings/settings.dart';
import '../../controllers/profile/test.dart';
import '../../functions/conversions.dart';

class SeminarAndEvents extends StatefulWidget {
  final List<int> category;
  final bool title;
  const SeminarAndEvents({
    super.key,
    required this.category,
    this.title = true,
  });

  @override
  State<SeminarAndEvents> createState() => _SeminarAndEventsState();
}

class _SeminarAndEventsState extends State<SeminarAndEvents> {
  final isLoading = false.obs;
  final connectItems = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    fetchAllEvents(widget.category);
  }

  Future<void> fetchAllEvents(List<int> category) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('${AppSettings.baseUrl}health/event-details'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"category": category}),
      );

      if (response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'] ?? [];
        connectItems.assignAll(
          data.map<Map<String, dynamic>>((item) {
            return {
              'tag': item['event_type_name'] ?? '',
              'tagBgColor': Colors.white,
              'tagTextColor': const Color(0xFF4E4E4E),
              'title': item['name'] ?? '',
              'date': formatDate(item['created_at'] ?? ''),
              'time': '14:30',
              'bgColor': parseHexColor(item['box_color'] ?? '#FFFFFF'),
            };
          }).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to load events');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Widget _buildEventCard(Map<String, dynamic> item) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item['bgColor'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
            decoration: BoxDecoration(
              color: item['tagBgColor'],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item['tag'],
              style: TextStyle(
                fontSize: 12,
                color: item['tagTextColor'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Center(
            child: Text(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),

          // Date & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item['date'], style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 20),
              Text(item['time'], style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),

          // Get Location Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
              ),
              child: const Text('GET LOCATION'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (connectItems.isEmpty) {
        return const SizedBox.shrink();
      }

      final check = connectItems.length;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            if (check != 0 && widget.title)
              Text(
                'Connect In Your Area',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.secondaryFontFamily,
                ),
              ),
            if (check != 0 && widget.title) SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: connectItems.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(connectItems[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
