
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';

class EmergencyHousingController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final RxList<Map<String, dynamic>> mainList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> shelterList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> topShelters = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> city = <Map<String, dynamic>>[].obs;
  final lister = [].obs;
  var selectedCity = "".obs;

  @override
  void onInit() {
    fetchCity();
    fetchShelter(cityId: 1);
    super.onInit();
  }

  void setLocation(double lat, double long) {
    latitude.value = lat;
    longitude.value = long;
  }

  late RxDouble userLatitude = 24.8624977.obs;
  late RxDouble userLongitude = 67.060363.obs;
  var isLoading = false.obs;

  void selectCity(String? value) {
    selectedCity.value = value ?? '';
    if (value == '') {
      shelterList.assignAll(mainList);
      topShelters.assignAll(mainList.take(3).toList());
    } else {
      final selectedCityId = int.tryParse(selectedCity.value) ?? -1;
      final filtered = mainList.where((shelter) {
        final cityId = int.tryParse(shelter['city_id'].toString()) ?? -1;
        return cityId == selectedCityId;
      }).toList();
      shelterList.assignAll(filtered);
      topShelters.assignAll(shelterList.take(3).toList());
    }
  }

  Future<void> fetchShelter({required int cityId}) async {
    final url = Uri.parse('${AppSettings.baseUrl}shelters/getShelters');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 201) {
      final apiResponse = jsonDecode(response.body);
      if (apiResponse is List) {
        mainList.assignAll(
          apiResponse.map((item) => item as Map<String, dynamic>).toList(),
        );
        selectCity('');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchCity() async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${AppSettings.baseUrl}shelters/Cities');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      final responseBody = json.decode(response.body);

      final data = responseBody;

      if (data is List) {
        city.value = data.map<Map<String, dynamic>>((item) {
          return {'id': item['id'] ?? '', 'name': item['name'] ?? ''};
        }).toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> getSingleShelter({required int id}) async {
    final lister = shelterList.firstWhere(
      (item) => item['id'] == id,
      orElse: () => <String, dynamic>{},
    );
    return lister;
  }
}
