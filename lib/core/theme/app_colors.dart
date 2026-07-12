import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Colors (Default)
  static const Color bgDark = Color(0xFF09090B);
  static const Color surfaceDark = Color(0xFF18181B);
  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);
  static const Color borderDark = Color(0xFF27272A);

  // Light Theme Colors (Optional)
  static const Color bgLight = Color(0xFFF9FAFB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFE5E7EB);

  // Shared Brand Colors
  static const Color primary = Color(0xFF2563EB); // Royal Blue
  static const Color accent = Color(0xFF06B6D4);  // Cyan
  static const Color success = Color(0xFF22C55E); // Green
  static const Color error = Color(0xFFEF4444);   // Red
  static const Color warning = Color(0xFFF59E0B); // Amber

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient textGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFA1A1AA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neonGlowGradient = LinearGradient(
    colors: [
      Color(0x332563EB), // 20% primary
      Color(0x3306B6D4), // 20% accent
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color shadowDark = Colors.black.withValues(alpha: 0.5);
  static Color shadowLight = Colors.grey.withValues(alpha: 0.1);
}
