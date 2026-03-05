
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  final DateTime parsedDate = DateTime.parse(inputDate);
  final DateFormat formatter = DateFormat('dd MMM yyyy');
  return formatter.format(parsedDate);
}

Color parseHexColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) hexColor = "FF$hexColor";
  return Color(int.parse(hexColor, radix: 16));
}

Color parseNameColor(String colorName) {
  switch (colorName.toLowerCase()) {
    case "orange":
      return const Color(0xFFFFE0B2);
    case "green":
      return const Color(0xFFC8E6C9);
    case "blue":
      return const Color(0xFFBBDEFB);
    case "purple":
      return const Color(0xFFE1BEE7);
    case "red":
      return const Color(0xFFFFCDD2);
    case "white":
      return Colors.white;
    default:
      return Colors.grey[200]!;
  }
}
