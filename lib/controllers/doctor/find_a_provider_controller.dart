import 'dart:convert';

import 'package:community_app/models/doctor_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';

class FindAProviderController extends GetxController {
  var requestId = 0.obs;
  var requestName = ''.obs;
  var isPaid = true.obs;
  var selectedOption = ''.obs;
  var selectedCity = "".obs;
  late RxDouble latitude = 0.0.obs;
  late RxDouble longitude = 0.0.obs;
  RxBool isLoadingMore = false.obs;
  final radius = 5;
  var isLoading = true.obs;
  final offset = 0.obs;
  final limit = 10;
  final selectedHospital = "".obs;
  final RxString searchQuery = ''.obs;
  RxList<DoctorList> apiDoctors = <DoctorList>[].obs;
  RxList<DoctorList> filteredProviders = <DoctorList>[].obs;
  RxList<DoctorList> paginatedDoctors = <DoctorList>[].obs;
  final RxList<Map<String, dynamic>> city = <Map<String, dynamic>>[].obs;

  Future<void> fetchCity() async {
    selectedCity.value = "";
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
        city.value =
            data.map<Map<String, dynamic>>((item) {
              return {'id': item['id'] ?? '', 'name': item['name'] ?? ''};
            }).toList();
      } else {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  void selectCity(String? value) {
    selectedCity.value = value ?? '';
    final cityID = int.parse(selectedCity.value);
    findDoctors(cityId: cityID);
    selectedHospital.value = "";
  }

  Future<void> findDoctors({int? hospitalID, int? cityId}) async {
    isLoadingMore.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}doctor/get-all-doctors');
    final nextOfSet = offset.value == 0 ? 0 : offset.value;
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({
        "hospital_id": hospitalID,
        "city_id": cityId,
        "offset": nextOfSet,
        "limit": 10,
      }),
    );
    final responseBody = json.decode(response.body);
    final data = responseBody['data'];
    print('Doctor: $data');
    if (data is List) {
      final doctors = data.map((item) => DoctorList.fromJson(item)).toList();
      if (doctors.isNotEmpty) {
        apiDoctors.addAll(doctors);
        filteredProviders.assignAll(apiDoctors);
      }
    }
  }

  void loadMore() {
    offset.value += 10;
    findDoctors();
  }

  @override
  void onInit() {
    super.onInit();
    filteredProviders.assignAll(apiDoctors);
  }

  void filterProviders(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProviders.assignAll(apiDoctors);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredProviders.assignAll(
        apiDoctors.where((provider) {
          final nameMatches = provider.name.toLowerCase().contains(
            lowerCaseQuery,
          );
          final fieldMatches = (provider.major.toLowerCase()).contains(
            lowerCaseQuery,
          );
          final hospitalMatches = (provider.venue.toLowerCase()).contains(
            lowerCaseQuery,
          );
          return nameMatches || fieldMatches || hospitalMatches;
        }).toList(),
      );
    }
  }
}
