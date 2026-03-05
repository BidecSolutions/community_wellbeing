import 'package:flutter/material.dart';
import 'colors.dart'; // Adjust the import path if necessary
import 'fonts.dart'; // Adjust the import path if necessary

class AppStyles {
  static const TextStyle headingLarge = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppFonts.secondaryFontFamily, // Or primary if you prefer
    fontSize: 18,
    color: AppColors.textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.secondaryFontFamily,
    fontSize: 16,
    color: AppColors.textColor,
  );
  static final TextStyle headingH1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );


}