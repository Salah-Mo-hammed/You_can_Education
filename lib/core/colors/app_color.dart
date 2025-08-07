import 'package:flutter/material.dart';

class AppColors {
  // Background: Deep black with dark gradient
  static const Color background = Color(0xFF0C0C0C);

  // Golden Gradient Highlights
  static const Color goldLight = Color(0xFFFFD67C);
  static const Color goldFinal = Color(0xFFFFB82E);
  static const Color goldDark = Color(0xFF8C5800);

  static const LinearGradient resetpass = LinearGradient(
    colors: [
      Color(0xFFE6A756), // warm amber
      Color(0xFFC97D27), // deeper burnt orange
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient register = LinearGradient(
    colors: [
      Color(0xFFD0492B), // rustic red-orange
      Color(0xFF8C1D14), // dark brick red
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF6E27A), Color(0xFFD4A017), Color(0xFF9C6A0D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Text Colors
  static const Color textPrimary = Color(0xFFF3C77B);
  static const Color textSecondary = Color(0xFFA98C67);

  // Icon Colors
  static const Color iconEmail = Color(0xFFFFB743); // Email icon
  static const Color iconPassword = Color(
    0xFFFFC667,
  ); // Password icon

  // Button Gradient
  static const Color buttonStart = Color(0xFFFFD67C);
  static const Color buttonEnd = Color(0xFFFFB82E);

  static const Color gold = Color(0xFFCBA973); // Gold
  static const Color lightGray = Color(0xFFD2D2D2); // Light Gray
  static const Color darkGray = Color(0xFF1D1B18); // Dark Gray/Black
  static const Color bronze = Color(0xFFB98E43); // Bronze
  static const Color mediumGray = Color(0xFF7E7D7D); // Medium Gray
  static const Color brown = Color(0xFF755C35); // Brown
  static const Color silverGray = Color(0xFFA7A7A7); // Silver Gray
  static const Color taupe = Color(0xFFA39179); // Taupe
  static const Color warmGray = Color(0xFFBEB6A7); // Warm Gray
  static const Color softBrown = Color(0xFFB5AAA2); // Soft Brown
}
