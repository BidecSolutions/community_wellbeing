import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_settings/colors.dart'; // your colors
import '../../controllers/doctor/doctor_slots_controller.dart';

class DoctorSlots extends StatelessWidget {
  DoctorSlots({super.key});

  final DoctorSlotsController controller = Get.put(DoctorSlotsController());
  final ScrollController scrollController = ScrollController();

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    // Jump to today's date after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      final todayIndex = controller.monthDates.indexWhere(
        (d) => _isSameDate(d, now),
      );
      if (scrollController.hasClients && todayIndex != -1) {
        scrollController.jumpTo((todayIndex * 70).toDouble());
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with month/year and arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMM().format(DateTime.now()),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    scrollController.animateTo(
                      (scrollController.offset - 150).clamp(
                        0.0,
                        scrollController.position.maxScrollExtent,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 16),
                ),
                IconButton(
                  onPressed: () {
                    scrollController.animateTo(
                      (scrollController.offset + 150).clamp(
                        0.0,
                        scrollController.position.maxScrollExtent,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Date carousel wrapped inside Obx to react to monthDates and selectedDate changes
        Obx(
          () => SizedBox(
            height: 80,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.monthDates.length,
              itemBuilder: (context, index) {
                final date = controller.monthDates[index];
                final isSelected = _isSameDate(
                  controller.selectedDate.value,
                  date,
                );

                return GestureDetector(
                  onTap: () => controller.selectedDate.value = date,
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.screenBg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primaryColor : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E().format(date),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Time slots card wrapped inside Obx to react to selectedDate and selectedTime changes
        Obx(() {
          final timeSlots = controller.slotsForSelectedDate;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD5EBFF), Color(0xFFF5F5F0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.6],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  children:
                      timeSlots.map((slot) {
                        final isSelected =
                            controller.selectedTime.value == slot;
                        return GestureDetector(
                          onTap: () => controller.selectedTime.value = slot,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                // fontWeight:
                                //     isSelected
                                //         ? FontWeight.bold
                                //         : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
