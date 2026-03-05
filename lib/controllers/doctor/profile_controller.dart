import 'dart:convert';
import 'package:community_app/models/doctor_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/settings.dart';
import '../../screens/profile/change_password.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  var doctorPrice = '50'.obs;
  final message = ''.obs;
  var doctorImage = ''.obs;
  var doctorName = ''.obs;
  var doctorSpec = ''.obs;
  var doctorDescription = ''.obs;
  var doctorExperience = ''.obs;
  var isLoading = true.obs;
  var isPaid = true.obs;
  final List<String> dates = [];
  final apiOPD = <DoctorOpdList>[].obs;
  final checkValue = <int>[];
  final selectedOpdType = 2.obs;
  Future<void> doctorSchedule({
    required int id,
    required String name,
    required String description,
    required String experience,
    required String image,
    required String spec,
    required String hospitalID,
    required List object,
  }) async {
    doctorImage.value = image;
    doctorSpec.value = spec;
    doctorName.value = name;
    doctorDescription.value = description;
    doctorExperience.value = experience;
    getDoctorSchedule(id: id, hospID: hospitalID);
  }

  Future<void> getDoctorSchedule({int? id, String? hospID}) async {
    final convertHospital =
        hospID == null || hospID == '' ? null : int.parse(hospID.toString());
    isLoading.value = true;
    final url = Uri.parse('${AppSettings.baseUrl}doctor/get-doctor-schedule');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"id": id, "hospital_id": convertHospital}),
    );
    final responseBody = json.decode(response.body);
    final data = responseBody[0];
    final ids = responseBody[1];
    if (data is List) {
      apiOPD.value = data.map((item) => DoctorOpdList.fromJson(item)).toList();
    }

    checkValue.clear();
    for (var item in ids) {
      if (item['id'] != null) {
        checkValue.add(item['slot_id']);
      }
    }
    isLoading.value = false;
  }

  RxList<DoctorOpdList> get filteredDoctors => RxList.from(
    apiOPD.where((item) => item.opdType == (isPaid.value ? 1 : 2)),
  );

  // Method to update selected opd type (called on toggle change)
  void updateOpdType(int value) {
    selectedOpdType.value = value;
  }

  List<String> getUpcomingDate({int numberOfMonths = 2, String? dayName}) {
    final today = DateTime.now();
    final endDate = DateTime(
      today.year,
      today.month + numberOfMonths,
      today.day,
    );
    final dates = <DateTime>[];
    final formattedDates = <String>[];
    if (dayName == null) return formattedDates;
    final weekdayMap = {
      'monday': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'friday': DateTime.friday,
      'saturday': DateTime.saturday,
      'sunday': DateTime.sunday,
    };

    final desiredWeekday = weekdayMap[dayName.toLowerCase()];
    if (desiredWeekday == null) return formattedDates;
    DateTime current = today;
    while (current.weekday != desiredWeekday) {
      current = current.add(Duration(days: 1));
    }
    while (current.isBefore(endDate)) {
      dates.add(current);
      current = current.add(Duration(days: 7));
    }
    final formatter = DateFormat('d MMM yyyy');
    for (var d in dates) {
      formattedDates.add(formatter.format(d));
    }
    return formattedDates;
  }

  Future<List<String>> getDate({required String? day}) async {
    dates.clear();
    dates.addAll(getUpcomingDate(dayName: day));
    return dates;
  }

  String changeDateFormat({required String date}) {
    final inputFormat = DateFormat('d MMM yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final dateStr = date;
    final parsedDate = inputFormat.parse(dateStr);
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  Future<bool> bookSlot({
    required int slotId,
    required String bookingDate,
    required int docID,
  }) async {
    isLoading.value = true;
    final convertDate = changeDateFormat(date: bookingDate);
    final url = Uri.parse('${AppSettings.baseUrl}doctor/book-doctor-slots');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode({"slot_id": slotId, "date": convertDate}),
    );
    final responseBody = json.decode(response.body);
    if (responseBody['status'] == 200) {
      message.value = responseBody['message'];
      getDoctorSchedule(id: docID);
      return true;
    }
    getDoctorSchedule(id: docID);
    return false;
  }
}
