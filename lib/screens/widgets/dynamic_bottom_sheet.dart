import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../controllers/profile/test.dart';

void showSearchableBottomSheet({
  required BuildContext context,
  required String api,
  required RxString name,
  required RxInt id,
  required String sheetName,
}) {
  RxList<Map<String, dynamic>> lister = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredList = <Map<String, dynamic>>[].obs;

  final message = "".obs;
  final searchController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final url = Uri.parse(AppSettings.baseUrl.toString() + api);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"status": 1}),
      );
      if (response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);
        final data = apiResponse['data'];

        if (data is List) {
          lister.value =
              data.map<Map<String, dynamic>>((item) {
                return {"id": item['id'], "name": item['name']};
              }).toList();
          filteredList.value = List.from(lister);
        }
      } else {
        message.value = 'Failed with status: ${response.statusCode}';
      }
    } catch (e) {
      message.value = 'Request Not Sent: $e';
    }
  }

  fetchData().then((_) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sheetName.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filteredList.value =
                          lister
                              .where(
                                (item) => item['name'].toLowerCase().contains(
                                  value.toLowerCase(),
                                ),
                              )
                              .toList();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Type to search...',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final isEven = index % 2 == 0;
                        return Container(
                          decoration: BoxDecoration(
                            color: isEven ? Colors.grey[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            leading: const Icon(
                              Icons.list_alt_outlined,
                              color: Colors.blueGrey,
                            ),
                            title: Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.blueGrey,
                            ),
                            onTap: () {
                              id.value = item['id'];
                              name.value = item['name'];
                              Get.back();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  });
}

// for get api
void showGetSearchableBottomSheet({
  required BuildContext context,
  required String api,
  required RxString name,
  required RxInt id,
  required String sheetName,
  String displayKey = "name",
}) {
  RxList<Map<String, dynamic>> lister = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredList = <Map<String, dynamic>>[].obs;

  final message = "".obs;
  final searchController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final url = Uri.parse(AppSettings.baseUrl.toString() + api);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiResponse = jsonDecode(response.body);

        List<dynamic> dataList = [];
        if (apiResponse is List) {
          dataList = apiResponse;
        } else if (apiResponse is Map && apiResponse['data'] is List) {
          dataList = apiResponse['data'];
        }

        lister.value =
            dataList.map<Map<String, dynamic>>((item) {
              return {
                "id": item['id'],
                "value": item[displayKey]?.toString() ?? "N/A",
              };
            }).toList();

        filteredList.value = List.from(lister);
      } else {
        message.value = 'Failed with status: ${response.statusCode}';
      }
    } catch (e) {
      message.value = 'Request Not Sent: $e';
    }
  }

  fetchData().then((_) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sheetName.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filteredList.value =
                          lister.where((item) {
                            return item['value'].toLowerCase().contains(
                              value.toLowerCase(),
                            );
                          }).toList();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Type to search...',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final isEven = index % 2 == 0;
                        return Container(
                          decoration: BoxDecoration(
                            color: isEven ? Colors.grey[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.list_alt_outlined,
                              color: Colors.blueGrey,
                            ),
                            title: Text(
                              item['value'] ?? "N/A",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.blueGrey,
                            ),
                            onTap: () {
                              id.value = item['id'];
                              name.value = item['value'] ?? "N/A";
                              Get.back();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  });
}
