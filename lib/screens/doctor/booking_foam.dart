import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/fonts.dart';
import '../../app_settings/colors.dart';
import '../../controllers/doctor/profile_controller.dart';
import '../widgets/snack_bar.dart';

class BookingForm extends GetView<ProfileController> {
  final String hospitalName;
  final int doctorFee;
  final String day;
  final String from;
  final String end;
  final int slotId;
  final int doctorID;
  final List<String> dates;

  const BookingForm({
    super.key,
    required this.hospitalName,
    required this.doctorFee,
    required this.day,
    required this.from,
    required this.end,
    required this.dates,
    required this .slotId,
    required this.doctorID,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDate = RxString(dates.first);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        borderRadius: BorderRadius.circular(0),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doctor Booking Form",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 16),

              // Hospital Name
              Align(
                alignment: Alignment.center,
                child: Text(
                  hospitalName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Doctor Fee: Rs. $doctorFee',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Schedule Table
              Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(3),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    children: [
                      _tableCell("Day", isHeader: true),
                      _tableCell("Time From", isHeader: true),
                      _tableCell("Time To", isHeader: true),
                    ],
                  ),
                  TableRow(
                    children: [
                      _tableCell(day),
                      _tableCell(from),
                      _tableCell(end),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Date Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: selectedDate.value,
                decoration: InputDecoration(
                  labelText: "Select Date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: dates
                    .map((date) => DropdownMenuItem(
                  value: date,
                  child: Text(date),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedDate.value = value;
                },
              )),
              SizedBox(height: 20),

              // Book Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await controller.bookSlot(slotId: slotId, bookingDate: selectedDate.value,docID: doctorID);
                      if (result == true) {
                        final snackBarShow = Snackbar(
                          title: 'Success',
                          message: controller.message.value.toString(),
                          type: 'success',
                        );
                        snackBarShow.show();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                      else {
                        final snackBarShow = Snackbar(
                          title: 'Error',
                          message: controller.message.value.toString(),
                          type: 'error',
                        );
                        snackBarShow.show();

                      }
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Book Slot for me",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
