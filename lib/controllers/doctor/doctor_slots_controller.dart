import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorSlotsController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final selectedTime = ''.obs;

  final RxList<DateTime> monthDates = <DateTime>[].obs;

  // Sample time slots mapped by yyyy-MM-dd string
  final Map<String, List<String>> timeSlotsMap = {
    DateFormat('yyyy-MM-dd').format(DateTime.now()): [
      '09:00 AM', '10:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '04:00 PM',
    ],
  };

  @override
  void onInit() {
    super.onInit();

    final now = DateTime.now();

    // Handle month overflow correctly
    final int nextMonth = now.month == 12 ? 1 : now.month + 1;
    final int nextYear = now.month == 12 ? now.year + 1 : now.year;

    // Getting last day of current month by going to day 0 of next month
    final end = DateTime(nextYear, nextMonth, 0);

    monthDates.assignAll(
      List.generate(end.day, (i) => DateTime(now.year, now.month, i + 1)),
    );

    // Clear selectedTime when selectedDate changes
    ever<DateTime>(selectedDate, (_) => selectedTime.value = '');
  }

  List<String> get slotsForSelectedDate {
    final key = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    return timeSlotsMap[key] ?? [];
  }
}
