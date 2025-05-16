import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF2E7D32); // Deep medical green
  static const Color primaryLight = Color(0xFF4CAF50); // Fresh green
  static const Color primaryDark = Color(0xFF1B5E20); // Forest green

  // Accent / Secondary Colors
  static const Color secondary = Color(0xFF0288D1); // Medical blue
  static const Color secondaryLight = Color(0xFF03A9F4); // Sky blue
  static const Color secondaryDark = Color(0xFF01579B); // Deep blue

  // Backgrounds
  static const Color background = Color(0xFFF5F9F5); // Soft mint white
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF4A4A4A);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Button Colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;

  // Error & Status
  static const Color error = Color(0xFFD32F2F); // Medical red
  static const Color success = Color(0xFF388E3C); // Success green
  static const Color warning = Color(0xFFFFA000); // Warning amber

  // Health-specific colors
  static const Color healthBlue = Color(0xFF1976D2); // Medical blue
  static const Color healthGreen = Color(0xFF43A047); // Healing green
  static const Color healthPurple = Color(0xFF7B1FA2); // Wellness purple
  static const Color healthTeal = Color(0xFF00796B); // Calming teal

  // Greys
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Transparent
  static const Color transparent = Colors.transparent;
}
