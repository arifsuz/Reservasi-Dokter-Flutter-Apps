import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static final TextStyle bodyText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textLight,
    height: 1.5,
  );

  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}