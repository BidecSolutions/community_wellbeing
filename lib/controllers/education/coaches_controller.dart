import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/coaches_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoachController extends GetxController {
  var isLoading = false.obs;
  var coaches = <Coach>[].obs;
  var errorMessage = ''.obs;

  var bookedSlots = <int, bool>{}.obs;
  var loadingSlots = <int, bool>{}.obs;

  Future<void> fetchCoaches() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final url = Uri.parse(
        "${AppSettings.baseUrl}education/list-learning-coach",
      );
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode({"status": 1}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        List data = jsonResponse["data"];
        coaches.value = data.map((e) => Coach.fromJson(e)).toList();
        log("✅ Coaches fetched: ${coaches.length}");
      } else {
        errorMessage.value = "Failed to load coaches";
      }
    } catch (e, s) {
      errorMessage.value = e.toString();
      log("❌ Exception: $e");
      log("❌ Stacktrace: $s");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookSlot(int slotId, String bookingDate) async {
    loadingSlots[slotId] = true;
    log("Booking API called with slot_id: $slotId, booking_date: $bookingDate");

    try {
      final url = Uri.parse(
        "${AppSettings.baseUrl}education/save-coach-slot-booking",
      );
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${box.read('token')}",
        },
        body: jsonEncode({"slot_id": slotId, "booking_date": bookingDate}),
      );

      log("API Response Code: ${response.statusCode}");
      log("API Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        bookedSlots[slotId] = true; // ✅ Mark only this slot as booked
        Get.snackbar("Success", "Slot booked successfully!");
        log("Slot $slotId booked successfully ✅");
      } else {
        Get.snackbar("Error", "Failed to book slot");
        log("Failed to book slot ❌");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      log("Exception: $e");
    } finally {
      loadingSlots[slotId] = false;
    }
  }

  bool isSlotBooked(int slotId) {
    return bookedSlots[slotId] ?? false;
  }

  bool isSlotLoading(int slotId) => loadingSlots[slotId] ?? false;

  @override
  void onInit() {
    fetchCoaches();
    super.onInit();
  }
}
