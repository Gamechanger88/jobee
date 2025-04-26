import 'package:flutter/material.dart';

// Color definitions based on Figma style guide
class AppColors {
  // Main Colors
  static const Color primary = Color(0xFF3B82F6); // Primary
  static const Color secondary = Color(0xFFFFD500); // Secondary

  // Alert & Status Colors
  static const Color success = Color(0xFF22C55E); // Success
  static const Color info = Color(0xFF3B82F6); // Info
  static const Color warning = Color(0xFFFFD500); // Warning
  static const Color error = Color(0xFFF43F5E); // Error
  static const Color disabled = Color(0xFF9CA3AF); // Disabled
  static const Color disabledButton = Color(0xFF9CA3AF); // Disabled Button

  // Greyscale
  static const Color grey900 = Color(0xFF111827);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey50 = Color(0xFFF9FAFB);

  // Gradients
  static const LinearGradient gradientYellow = LinearGradient(
    colors: [Color(0xFFFACC15), Color(0xFFFFE580)], // 0% FACC15, 100% FFE580
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  static const LinearGradient gradientBlue = LinearGradient(
    colors: [Color(0xFF335EF7), Color(0xFF5F82FF)], // 0% 335EF7, 100% 5F82FF
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  static const LinearGradient gradientGreen = LinearGradient(
    colors: [Color(0xFF22BB9C), Color(0xFF35DEBC)], // 0% 22BB9C, 100% 35DEBC
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  static const LinearGradient gradientOrange = LinearGradient(
    colors: [Color(0xFFFB9400), Color(0xFFFFAB38)], // 0% FB9400, 100% FFAB38
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  static const LinearGradient gradientRed = LinearGradient(
    colors: [Color(0xFFFF4D67), Color(0xFFFF8A9B)], // 0% FF4D67, 100% FF8A9B
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );

  // Dark Colors
  static const Color dark1 = Color(0xFF111827);
  static const Color dark2 = Color(0xFF1F2937);
  static const Color dark3 = Color(0xFF374151);

  // Others
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFF43F5E);
  static const Color pink = Color(0xFFEC4899);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color deepPurple = Color(0xFF6D28D9);
  static const Color indigo = Color(0xFF4F46E5);
  static const Color blue = Color(0xFF3B82F6);
  static const Color lightBlue = Color(0xFF0EA5E9);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color teal = Color(0xFF14B8A6);
  static const Color green = Color(0xFF22C55E);
  static const Color lightGreen = Color(0xFF34D399);
  static const Color lime = Color(0xFF65A30D);
  static const Color yellow = Color(0xFFFFD500);
  static const Color amber = Color(0xFFF59E0B);
  static const Color orange = Color(0xFFF97316);
  static const Color deepOrange = Color(0xFFEA580C);
  static const Color brown = Color(0xFF8F5A2E);
  static const Color blueGrey = Color(0xFF64748B);

  // Background Colors
  static const Color backgroundBlue = Color(0xFFEFF6FF);
  static const Color backgroundGreen = Color(0xFFF0FDF4);
  static const Color backgroundOrange = Color(0xFFFFF7ED);
  static const Color backgroundPink = Color(0xFFFFF1F2);
  static const Color backgroundYellow = Color(0xFFFFFBE6);
  static const Color backgroundPurple = Color(0xFFF5F3FF);

  // Transparent Colors
  static const Color transparentBlue = Color(0x263B82F6);
  static const Color transparentOrange = Color(0x26F97316);
  static const Color transparentYellow = Color(0x26FFD500);
  static const Color transparentRed = Color(0x26F43F5E);
  static const Color transparentGreen = Color(0x2622C55E);
  static const Color transparentPurple = Color(0x268B5CF6);
  static const Color transparentCyan = Color(0x2606B6D4);
}
