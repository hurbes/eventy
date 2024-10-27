import 'package:flutter/material.dart';

// Primary Colors
const Color kcPrimaryColor = Color(0xFFFF4E8D);
const Color kcPrimaryColorDark = Color(0xFF300151);

// Background Colors
const Color kcBackgroundColor = Color(0xff22141a);
const Color kcBackgroundColorLight = Color(0xff2A1B21);

// Grey Scale
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);

// Overlay Colors
const Color kcOverlayDark = Color(0x99000000); // Black with 60% opacity
const Color kcOverlayLight = Color(0x0DFFFFFF); // White with 5% opacity

// Semantic Colors
const Color kcSuccessColor = Color(0xFF4CAF50);
const Color kcWarningColor = Color(0xFFFFC107);
const Color kcErrorColor = Color(0xFFF44336);

// Text Colors
const Color kcTextPrimaryColor = Colors.white;
const Color kcTextSecondaryColor = Color(0xFF9E9E9E);
const Color kcTextTertiaryColor = Color(0xFF757575);

// Component Colors
class ComponentColors {
  // Button Colors
  static const Color buttonPrimary = kcPrimaryColor;
  static const Color buttonDisabled = Color(0xFF9E9E9E);
  static const Color buttonSecondary = Colors.grey;

  // Input Field Colors
  static const Color inputBackground =
      Color(0x0DFFFFFF); // White with 5% opacity
  static const Color inputBorder = Color(0x1AFFFFFF); // White with 10% opacity
  static const Color inputHintText = Colors.grey;
  static const Color inputErrorText = kcPrimaryColor;
  static const Color inputSuccessIcon = kcPrimaryColor;

  // Card Colors
  static const Color cardBackground =
      Color(0x0DFFFFFF); // White with 5% opacity
  static const Color cardBorder = Color(0x1AFFFFFF); // White with 10% opacity
  static const Color cardOverlay = Color(0x99000000); // Black with 60% opacity

  // Badge Colors
  static const Color badgeBackground = kcPrimaryColor;
  static const Color badgeText = Colors.white;

  // Timer Colors
  static const Color timerNormal = Color(0xFF4CAF50);
  static const Color timerWarning = Color(0xFFFFC107);
  static const Color timerCritical = Color(0xFFF44336);

  // Icon Colors
  static const Color iconPrimary = Colors.white;
  static const Color iconSecondary = Colors.grey;
  static const Color iconAccent = kcPrimaryColor;

  // Navigation Colors
  static const Color bottomNavBackground = kcBackgroundColor;
  static const Color bottomNavActive = kcPrimaryColor;
  static const Color bottomNavInactive = Colors.grey;

  // Progress Bar Colors
  static const Color progressBackground =
      Color(0x4D9E9E9E); // Grey with 30% opacity
  static const Color progressFill = kcPrimaryColor;

  // Price Tag Colors
  static const Color priceTagBackground =
      Color(0x33FF4E8D); // Primary with 20% opacity
  static const Color priceTagText = kcPrimaryColor;
}

// Gradient Colors
class GradientColors {
  static const List<Color> cardGradient = [
    Colors.transparent,
    Color(0xE6000000), // Black with 90% opacity
  ];

  static const List<Color> headerGradient = [
    Color(0xB3000000), // Black with 70% opacity
    Colors.transparent,
  ];

  static const List<Color> imageOverlayGradient = [
    Color(0xB3000000), // Black with 70% opacity
    Colors.transparent,
    Color(0x4D000000), // Black with 30% opacity
  ];

  static const List<double> imageOverlayStops = [0.0, 0.3, 1.0];
}

// Shadow Colors
class ShadowColors {
  static const Color defaultShadow =
      Color(0x33000000); // Black with 20% opacity
  static const Color darkShadow = Color(0x66000000); // Black with 40% opacity
}

// Shimmer Colors
class ShimmerColors {
  static const Color baseColor = Color(0xFF424242); // Grey 800
  static const Color highlightColor = Color(0xFF616161); // Grey 700
}

// Helper method to create opacity variants
Color withOpacity(Color color, double opacity) => color.withOpacity(opacity);
